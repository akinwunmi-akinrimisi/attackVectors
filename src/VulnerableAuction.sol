// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableAuction {
    address public highestBidder;
    uint256 public highestBid;

    function placeBid() public payable {
        require(msg.value > highestBid, "Bid must be higher than the current highest bid");

        // Refund the previous highest bidder
        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call{value: highestBid}("");
            require(success, "Refund failed");
        }

        highestBid = msg.value;
        highestBidder = msg.sender;
    }
}
