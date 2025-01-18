// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ArrayBounds.sol";

contract ArrayBoundsTest is Test {
    ArrayBounds public arrayBounds;

    function setUp() public {
        arrayBounds = new ArrayBounds();
        arrayBounds.addNumber(10);
        arrayBounds.addNumber(20);
    }

    function testAccessWithinBounds() public {
        uint256 value = arrayBounds.getNumber(1);
        emit log_named_uint("Value at Index 1", value);
        assertEq(value, 20); // Index 1 is valid
    }

    function testAccessOutOfBounds() public {
        // Attempt to access an invalid index
        vm.expectRevert(stdError.indexOOBError);
        arrayBounds.getNumber(3); // Index 3 is out of bounds
    }
}
