// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZeroCodeVulnerable {
    function callExternal(address target) public returns (bool) {
        // Vulnerability: Assumes the target address has executable code
        (bool success, ) = target.call(abi.encodeWithSignature("doSomething()"));
        return success; // Returns true even if the target has no code
    }
}
