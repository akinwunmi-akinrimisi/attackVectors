// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DefaultVisibility {
    uint256 public value;

    // Intentionally omitting the visibility modifier
    function setValue(uint256 _value) {
        value = _value; // This function defaults to public
    }

    function resetValue() {
        value = 0; // This function also defaults to public
    }
}
