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
    MockERC721 public mockToken;

    function setUp() public {
        registry = new ERC6551Registry();
        implementation = new ExampleERC6551Account();
    }

    function testDeploy() public {
        address deployedAccount = registry.createAccount(
            address(implementation),
            block.chainid,
            address(mockToken),
            1,
            12345,
            ""
        );
        assertTrue(deployedAccount != address(0));

        address predictedAccount = registry.account(
            address(implementation),
            block.chainid,
            address(mockToken),
            1,
            12345
        );

        assertEq(deployedAccount, predictedAccount);
    }

    // function testToken() public {
    //     (
    //         uint256 chainId,
    //         address tokenContract,
    //         uint256 returnedTokenId
    //     ) = account.token();

    //     assertEq(chainId, block.chainid, "ChainId does not match");
    // }

    // function testExecute() public {
    //     uint256 value = 0;
    //     bytes memory data = abi.encodeWithSelector(
    //         IERC721.transferFrom.selector,
    //         nftOwner,
    //         receipientAddress,
    //         tokenId
    //     );
    //     bytes memory result = account.execute(
    //         address(mockToken),
    //         value,
    //         data,
    //         0
    //     );
    //     assertEq(result, "");
    // }
}
