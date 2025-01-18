// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherBomb {
    constructor(address payable target) payable {
        require(msg.value > 0, "No Ether sent");
        // Send Ether to the target contract during deployment
        (bool success, ) = target.call{value: msg.value}("");
        require(success, "Ether transfer failed");
    }
}
