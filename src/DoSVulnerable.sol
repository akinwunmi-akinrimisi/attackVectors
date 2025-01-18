// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DoSVulnerable {
    address[] public recipients;

    function addRecipient(address recipient) public {
        recipients.push(recipient);
    }

    function distributeFunds() public payable {
        require(msg.value > 0, "No funds to distribute");

        uint256 amountPerRecipient = msg.value / recipients.length;

        for (uint256 i = 0; i < recipients.length; i++) {
            (bool success, ) = recipients[i].call{value: amountPerRecipient}("");
            require(success, "Transfer failed"); // Vulnerability: Entire process halts if one transfer fails
        }
    }
}
