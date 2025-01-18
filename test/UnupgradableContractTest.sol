// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/UnupgradableContract.sol";

contract UnupgradableContractTest is Test {
    UnupgradableContract public unupgradableContract;

    function setUp() public {
        unupgradableContract = new UnupgradableContract();
    }

    function testSetAndGetValue() public {
        unupgradableContract.setValue(42);

        uint256 value = unupgradableContract.getValue();
        emit log_named_uint("Stored Value", value);

        assertEq(value, 42);
    }

    function testPermanentBug() public {
        // Simulate a bug that affects functionality
        // For example: a logic error in `setValue`
        // This cannot be fixed without redeploying the contract
    }
}
