// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaliciousRecipient {
    fallback() external payable {
        revert("I refuse to accept funds"); // Always revert to block Ether transfer
    }
}
