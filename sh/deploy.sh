#bin/bash
# registryのデプロイ
OUTPUT=$(forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/ERC6551Registry.sol:ERC6551Registry)
REGISTRY_ADDRESS=$(echo "$OUTPUT" | grep "Deployed to" | awk '{print $3}')
echo "REGISTRY_ADDRESS: $REGISTRY_ADDRESS"

# NFTのデプロイ
OUTPUT=$(forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/NFT.sol:NFT --constructor-args name="testToken" symbol="TEST" uri="http://google.co.jp")
NFT_ADDRESS=$(echo "$OUTPUT" | grep "Deployed to" | awk '{print $3}')
echo "NFT_ADDRESS: $NFT_ADDRESS"

ACCOUNT1=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
# NFTをmintして指定のアカウントに送る
OUTPUT=$(cast send $NFT_ADDRESS "mintTo(address)" $ACCOUNT1 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80)

# Accountのデプロイ
OUTPUT=$(forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/ExampleERC6551Account.sol:ExampleERC6551Account)
ACCOUNT_ADDRESS=$(echo "$OUTPUT" | grep "Deployed to" | awk '{print $3}')
echo "ACCOUNT_ADDRESS: $ACCOUNT_ADDRESS"

# RegistryにAccount, NFTを登録
OUTPUT=$(cast send $REGISTRY_ADDRESS "createAccount(address)(uint256)(address)(uint256)(uint256)(bytes)" $ACCOUNT_ADDRESS 31337 $NFT_ADDRESS 1 12345 ""  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80)
echo "OUTPUT: $OUTPUT"