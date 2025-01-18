// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MissingAccessControl {
    address public owner;
    uint256 public funds;

    constructor() {
        owner = msg.sender;
        funds = 1000 ether; // Simulated funds
    }

    function deposit() public payable {
        funds += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount <= funds, "Not enough funds");
        funds -= amount;

        // Vulnerability: No access control, anyone can call this function
        payable(msg.sender).transfer(amount);
    }
}

