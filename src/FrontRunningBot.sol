// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableAuction.sol";

contract FrontRunningBot {
    VulnerableAuction public auction;

    constructor(address _auctionAddress) {
        auction = VulnerableAuction(_auctionAddress);
    }

    function executeFrontRun() public payable {
        uint256 targetBid = auction.highestBid() + 1 ether;
        require(msg.value >= targetBid, "Not enough Ether to front-run");

        // Front-run the current highest bid
        auction.placeBid{value: targetBid}();
    }

    receive() external payable {}
}
