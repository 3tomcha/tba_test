pragma solidity ^0.8.0;

import "../../src/IERC6551Account.sol";

contract MockERC6551Account is IERC6551Account {
    receive() external payable {}

    function token()
        external
        view
        override
        returns (uint256, address, uint256)
    {
        return (0, address(0), 0);
    }

    function state() external view override returns (uint256) {
        return 0;
    }

    function isValidSigner(
        address signer,
        bytes calldata
    ) external view override returns (bytes4) {
        return bytes4(0);
    }
}
