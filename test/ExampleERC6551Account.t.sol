// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ExampleERC6551Account.sol";
import "../src/Counter.sol";
import "./mocks/MockERC721.sol";
import "./mocks/MockERC6551Account.sol";
import "../src/ERC6551Registry.sol";

contract ExampleERC6551AccountTest is Test {
    ExampleERC6551Account public implementation;
    ERC6551Registry public registry;
    MockERC721 nft = new MockERC721();

    function setUp() public {
        registry = new ERC6551Registry();
        implementation = new ExampleERC6551Account(
            31337,
            address(nft),
            1,
            address(this)
        );
    }

    function testDeploy() public {
        address deployedAccount = registry.createAccount(
            address(implementation),
            block.chainid,
            address(nft),
            0,
            0,
            ""
        );
        assertTrue(deployedAccount != address(0));

        address predictedAccount = registry.account(
            address(implementation),
            block.chainid,
            address(nft),
            0,
            0
        );

        assertEq(deployedAccount, predictedAccount);
    }

    function testExecute() public {
        nft.mint(vm.addr(1), 1);
        assertEq(nft.ownerOf(1), vm.addr(1));
        address account = registry.createAccount(
            address(implementation),
            block.chainid,
            address(nft),
            1,
            0,
            ""
        );
        assertTrue(account != address(0));

        IERC6551Account accountInstance = IERC6551Account(payable(account));
        IERC6551Executable executableAccountInstance = IERC6551Executable(
            account
        );
        vm.deal(account, 1 ether);
        vm.prank(vm.addr(1));
        executableAccountInstance.execute(
            payable(vm.addr(2)),
            0.5 ether,
            "",
            0
        );
        assertEq(account.balance, 0.5 ether);
        assertEq(vm.addr(2).balance, 0.5 ether);
        assertEq(accountInstance.state(), 1);
    }
}
