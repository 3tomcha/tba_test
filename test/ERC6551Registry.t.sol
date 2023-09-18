pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ERC6551Registry.sol";
import "./mocks/MockERC6551Account.sol";
import "forge-std/console.sol";

contract MockERC6551 {}

contract ERC6551RegistryTest is Test {
    ERC6551Registry registry;
    MockERC6551Account implementation;

    uint256 dummyChainId = 1;
    address dummyTokenContract =
        address(0x1234567890123456789012345678901234567890);
    uint256 dummyTokenId = 1;
    uint256 dummySalt = 12345;

    function setUp() public {
        registry = new ERC6551Registry();
        implementation = new MockERC6551Account();
    }

    function testCreateAccount() public {
        // アカウントを作成
        address createdAccount = registry.createAccount(
            address(implementation),
            dummyChainId,
            dummyTokenContract,
            dummyTokenId,
            dummySalt,
            ""
        );

        // // 期待されるアカウントアドレスを取得
        address expectedAccount = registry.account(
            address(implementation),
            dummyChainId,
            dummyTokenContract,
            dummyTokenId,
            dummySalt
        );

        assertEq(
            createdAccount,
            expectedAccount,
            "Account addresses do not match"
        );
    }
}
