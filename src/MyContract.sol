pragma solidity ^0.8.0;

import "./IERC6551Registry.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "./ExampleERC6551Account.sol";
import "./IERC6551Executable.sol";

contract MyContract {
    ExampleERC6551Account public implementation;
    IERC6551Registry public registry;
    IERC721 public nft;

    constructor(address _implementation, address _registry, address _nft) {
        implementation = ExampleERC6551Account(payable(_implementation));
        registry = IERC6551Registry(_registry);
        nft = IERC721(_nft);
    }

    function createAndExecute(
        uint256 tokenId,
        address to,
        uint256 value,
        bytes calldata data
    ) external {
        // TokenBoundAccountの作成
        address tokenBoundAccount = registry.createAccount(
            address(implementation),
            1,
            address(nft),
            tokenId,
            0,
            ""
        );

        // tokenBoundAccountにEtherを送金
        payable(tokenBoundAccount).transfer(1 ether);

        IERC6551Executable executableAccountInstance = IERC6551Executable(
            tokenBoundAccount
        );
        executableAccountInstance.execute(to, value, data, 0);
    }
}
