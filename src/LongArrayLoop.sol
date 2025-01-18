// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongArrayLoop {
    address[] public recipients;

    function addRecipient(address _recipient) public {
        recipients.push(_recipient);
    }

    function distributeFunds() public payable {
        require(msg.value > 0, "No funds to distribute");
        uint256 amountPerRecipient = msg.value / recipients.length;

        // Vulnerability: Unbounded loop
        for (uint256 i = 0; i < recipients.length; i++) {
            (bool success, ) = recipients[i].call{value: amountPerRecipient}("");
            require(success, "Transfer failed");
        }
    }
}
