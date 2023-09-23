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
    MockERC721 public nft;

    function setUp() public {
        registry = new ERC6551Registry();
        implementation = new ExampleERC6551Account();
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
        nft.mint(address(2), 3);
        // address account = registry.createAccount(
        //     address(implementation),
        //     block.chainid,
        //     address(nft),
        //     1,
        //     0,
        //     ""
        // );
        // assertTrue(account != address(0));
    }
}
