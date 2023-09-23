pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/interfaces/IERC721.sol";

contract MockERC721 is ERC721 {
    constructor() ERC721("MockERC721", "MockERC721") {}

    function mint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    // テストのための関数を追加
    function setApprovalForAllForTest(
        address operator,
        bool approved
    ) external {
        setApprovalForAll(operator, approved);
    }
}
