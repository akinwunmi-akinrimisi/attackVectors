// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/DefaultVisibility.sol";

contract DefaultVisibilityTest is Test {
    DefaultVisibility public defaultVisibility;

    function setUp() public {
        defaultVisibility = new DefaultVisibility();
    }

    function testExploitSetValue() public {
        // Attacker directly calls the `setValue` function
        defaultVisibility.setValue(999);

        uint256 value = defaultVisibility.value();
        emit log_named_uint("Value After Exploit", value);

        // Assert that the value was changed by an unauthorized call
        assertEq(value, 999);
    }

    function testExploitResetValue() public {
        // Set an initial value
        defaultVisibility.setValue(100);

        // Attacker directly calls the `resetValue` function
        defaultVisibility.resetValue();

        uint256 value = defaultVisibility.value();
        emit log_named_uint("Value After Reset Exploit", value);

        // Assert that the value was reset by an unauthorized call
        assertEq(value, 0);
    }
}
