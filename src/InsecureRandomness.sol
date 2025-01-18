// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsecureRandomness {
    address[] public players;

    function enterLottery() public payable {
        require(msg.value == 1 ether, "Must send exactly 1 Ether");
        players.push(msg.sender);
    }

    function pickWinner() public {
        require(players.length > 0, "No players in the lottery");

        // Vulnerability: Insecure randomness using block.timestamp and block.difficulty
        uint256 randomIndex = uint256(
            keccak256(abi.encodePacked(block.timestamp, block.difficulty, players))
        ) % players.length;

        address winner = players[randomIndex];

        // Transfer the entire balance to the winner
        (bool success, ) = winner.call{value: address(this).balance}("");
        require(success, "Transfer failed");

        // Reset the lottery
        delete players;
    }
}
