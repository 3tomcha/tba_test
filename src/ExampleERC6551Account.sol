pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/interfaces/IERC165.sol";
import "openzeppelin-contracts/contracts/interfaces/IERC721.sol";
import "openzeppelin-contracts/contracts/interfaces/IERC1271.sol";
import "openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol";
import "./IERC6551Account.sol";
import "./IERC6551Executable.sol";

contract ExampleERC6551Account is
    IERC165,
    IERC1271,
    IERC6551Account,
    IERC6551Executable
{
    uint256 public state;

    uint256 public immutable chainId;
    address public immutable tokenContract;
    uint256 public immutable tokenId;
    address public immutable entryPoint;

    constructor(
        uint256 _chainId,
        address _tokenContract,
        uint256 _tokenId,
        address _entryPoint
    ) {
        chainId = _chainId;
        tokenContract = _tokenContract;
        tokenId = _tokenId;
        entryPoint = _entryPoint;
    }

    receive() external payable {}

    function execute(
        address to,
        uint256 value,
        bytes calldata data,
        uint256 operation
    ) external payable returns (bytes memory result) {
        require(_isValidSigner(msg.sender), "Invalid signer");
        require(operation == 0, "Invalid operation");

        ++state;

        bool success;
        (success, result) = to.call{value: value}(data);

        if (!success) {
            assembly {
                revert(add(result, 32), mload(result))
            }
        }
    }

    function isValidSigner(
        address signer,
        bytes calldata
    ) external view returns (bytes4) {
        if (_isValidSigner(signer)) {
            return IERC6551Account.isValidSigner.selector;
        }

        return bytes4(0);
    }

    function isValidSignature(
        bytes32 hash,
        bytes memory signature
    ) external view returns (bytes4 magicValue) {
        bool isValid = SignatureChecker.isValidSignatureNow(
            owner(),
            hash,
            signature
        );

        if (isValid) {
            return IERC1271.isValidSignature.selector;
        }

        return "";
    }

    function supportsInterface(
        bytes4 interfaceId
    ) external pure returns (bool) {
        return (interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IERC6551Account).interfaceId ||
            interfaceId == type(IERC6551Executable).interfaceId);
    }

    function _isValidSigner(address signer) internal view returns (bool) {
        return signer == owner() || signer == entryPoint;
    }

    function token() public view returns (uint256, address, uint256) {
        return (chainId, tokenContract, tokenId);
    }

    function owner() public view returns (address) {
        if (chainId != block.chainid) return address(0);
        return IERC721(tokenContract).ownerOf(tokenId);
    }
}
