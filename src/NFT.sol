// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/utils/Context.sol";
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFT is ERC721Enumerable {
    using Strings for uint256;

    string baseURI = "";

    constructor(
        string memory name,
        string memory symbol,
        string memory uri
    ) ERC721(name, symbol) {
        require(bytes(uri).length > 0, "uri is empty");
        baseURI = uri;
    }

    function mintTo(address to) public virtual {
        _mint(to, totalSupply());
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }
}
