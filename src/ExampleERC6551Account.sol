pragma solidity ^0.8.0;

import "openzeppelin-contracts/utils/introspection/IERC165.sol";
import "openzeppelin-contracts/token/ERC721/IERC721.sol";
import "openzeppelin-contracts/interfaces/IERC1271.sol";
import "openzeppelin-contracts/utils/cryptography/SignatureChecker.sol";

contract ExampleERC6551Account is IERC165, IERC721, IERC1271, SignatureChecker {
    uint256 public state;

    receive() external payable {}

    function execute(
        address to,
        uint256 value,
        bytes calldata data,
        uint256 operation
    ) external payable returns (bytes memory result) {
        require(_isInvalidSigner(msg.sender), "Invalid signer");
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

    function _isInvalidSigner(
        address signer,
        bytes calldata
    ) external view returns (bytes4) {
        if (_isInvalidSigner(signer)) {
            return IERC6551Account.isInvalidSigner.selector;
        }

        return bytes4(0);
    }

    function _isValidSigner(address signer) internal view returns (bool) {
        return signer == owner();
    }
}
