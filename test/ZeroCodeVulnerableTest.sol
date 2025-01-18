// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ZeroCodeVulnerable.sol";

contract ZeroCodeVulnerableTest is Test {
    ZeroCodeVulnerable public zeroCodeVulnerable;

    address public externalAccount = address(0x1234); // An address with no deployed code

    function setUp() public {
        zeroCodeVulnerable = new ZeroCodeVulnerable();
    }

    function testCallExternalWithZeroCode() public {
        // Attempt to call a function on an address with no code
        bool success = zeroCodeVulnerable.callExternal(externalAccount);

        emit log_named_address("Target Address", externalAccount);
        emit log_named_uint("Code Size", externalAccount.code.length);
        emit log_named_string("Call Result", success ? "Success" : "Failure");

        // Assert that the address has no code
        assertEq(externalAccount.code.length, 0);

        // The call returns true even though the target has no code
        assertEq(success, true);
    }
}
