// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VulnerableAuction.sol";
import "../src/FrontRunningBot.sol";

contract FrontRunningTest is Test {
    VulnerableAuction public auction;
    FrontRunningBot public bot;

    address public user1 = address(0x1234);
    address public user2 = address(0x5678);

    function setUp() public {
        auction = new VulnerableAuction();
        bot = new FrontRunningBot(address(auction));

        // Fund users and bot
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
        vm.deal(address(bot), 10 ether);
    }

    function testFrontRunningAttack() public {
        // User1 places a legitimate bid
        vm.startPrank(user1);
        auction.placeBid{value: 1 ether}();
        vm.stopPrank();

        // Front-running bot observes and front-runs with a higher bid
        vm.startPrank(address(bot));
        bot.executeFrontRun{value: 2 ether}();
        vm.stopPrank();

        // Verify the bot becomes the highest bidder
        assertEq(auction.highestBidder(), address(bot));
        assertEq(auction.highestBid(), 2 ether);

        emit log_named_address("Highest Bidder", auction.highestBidder());
        emit log_named_uint("Highest Bid", auction.highestBid());
    }
}
