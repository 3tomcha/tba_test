pragma solidity ^0.8.0;
import "forge-std/Test.sol";
import "../src/ExampleERC6551Account.sol";
import "../src/Counter.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract MockERC721 is ERC721 {
    constructor() ERC721("MockERC721", "MockERC721") {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }
}

contract ExampleERC6551AccountTest is Test {
    ExampleERC6551Account public account;
    MockERC721 public mockToken;
    address nftOwner = address(1);
    address receipientAddress = address(2);
    uint256 tokenId = 1;

    function setup() public {
        mockToken = new MockERC721();
        mockToken.mint(nftOwner, tokenId);
        account = new ExampleERC6551Account();
    }

    function testExecute() public {
        uint256 value = 0;
        bytes memory data = abi.encodeWithSelector(
            IERC721.transferFrom.selector,
            nftOwner,
            receipientAddress,
            tokenId
        );
        bytes memory result = account.execute(
            address(mockToken),
            value,
            data,
            0
        );
        assertEq(result, "");
    }
}
