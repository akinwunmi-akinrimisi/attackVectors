// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableImplementation {
    address public owner;

    function initialize(address _owner) public {
        // Allows anyone to initialize the contract
        owner = _owner;
    }
}
