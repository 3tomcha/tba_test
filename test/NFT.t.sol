// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "../src/NFT.sol";

contract NFTTest is Test {
    NFT public nftContract;

    function setUp() public {
        nftContract = new NFT("NFT", "NFT", "https://example.com/");
    }

    function testMintTo() public {
        address user1 = address(1);
        address user2 = address(2);
        nftContract.mintTo(user1);
        nftContract.mintTo(user2);
        uint256 tokenIndex1 = nftContract.tokenOfOwnerByIndex(user1, 0);
        uint256 tokenIndex2 = nftContract.tokenOfOwnerByIndex(user2, 0);
        assertEq(tokenIndex1, 0);
        assertEq(tokenIndex2, 1);
    }

    function testTokenURI(uint256 index) public {
        string memory result = nftContract.tokenURI(index);
        string memory expected = string(
            abi.encodePacked(
                "https://example.com/",
                Strings.toString(index),
                ".json"
            )
        );
        assertEq(result, expected);
    }
}
