// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UncheckedCall {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Vulnerability: External call's return value is not checked
        (bool success, ) = msg.sender.call{value: amount}("");
        balances[msg.sender] -= amount;

        // The contract assumes `call` succeeded, even if it failed
    }
}
