// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/InsecureRandomness.sol";

contract InsecureRandomnessTest is Test {
    InsecureRandomness public insecureRandomness;

    address public player1 = address(0x1234);
    address public player2 = address(0x5678);

    function setUp() public {
        insecureRandomness = new InsecureRandomness();
        vm.deal(player1, 5 ether);
        vm.deal(player2, 5 ether);
    }

    function testPredictableRandomness() public {
        // Player1 and Player2 enter the lottery
        vm.startPrank(player1);
        insecureRandomness.enterLottery{value: 1 ether}();
        vm.stopPrank();

        vm.startPrank(player2);
        insecureRandomness.enterLottery{value: 1 ether}();
        vm.stopPrank();

        // Simulate miner or attacker predicting the winner
        uint256 predictedIndex = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp, // Simulate predictable timestamp
                    block.prevrandao,
                    insecureRandomness.players(0) // Assuming you want the first player
                )
            )
        ) % 2;

        emit log_named_uint("Predicted Winner Index", predictedIndex);

        // Simulate winner selection
        insecureRandomness.pickWinner(); 
    }
}
