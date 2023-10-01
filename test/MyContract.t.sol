pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/IERC6551Registry.sol";
import "../src/ERC6551Registry.sol";
import "../src/ExampleERC6551Account.sol";
import "../src/IERC6551Executable.sol";
import "./mocks/MockERC721.sol";
import "../src/MyContract.sol";

contract MyContractTest is Test {
    ExampleERC6551Account public implementation;
    IERC6551Registry public registry;
    MockERC721 public nft;

    function setUp() public {
        registry = new ERC6551Registry();
        nft = new MockERC721();
        implementation = new ExampleERC6551Account(
            31337,
            address(nft),
            1,
            address(this)
        );
    }

    function testCreateAndExecute() public {
        nft.mint(vm.addr(1), 1);

        MyContract myContract = new MyContract(
            address(implementation),
            address(registry),
            address(nft)
        );

        vm.deal(address(myContract), 1 ether);

        vm.deal(address(implementation), 1 ether);
        vm.prank(vm.addr(1));

        myContract.createAndExecute(1, vm.addr(2), 0.5 ether, "");
    }
}
