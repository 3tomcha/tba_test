pragma solidity ^0.8.0;
import "forge-std/Test.sol";
import "../src/ExampleERC6551Account.sol";
import "../src/Counter.sol";

contract ExampleERC6551AccountTest is Test {
    ExampleERC6551Account public account;

    function setup() public {
        account = new ExampleERC6551Account();
    }

    function testExecute() public {
        address user1 = address(1);
        uint256 value = 100;
        bytes memory data = abi.encodeWithSelector(
            Counter.setNumber.selector,
            1
        );
        bytes memory result = account.execute(user1, value, data, 0);
        assertEq(result, "");
    }
}
