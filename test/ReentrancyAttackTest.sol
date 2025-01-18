// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VulnerableReentrancy.sol";
import "../src/ReentrancyAttacker.sol";

contract ReentrancyAttackTest is Test {
    VulnerableReentrancy public vulnerableContract;
    ReentrancyAttacker public attacker;

    function setUp() public {
        vulnerableContract = new VulnerableReentrancy();
        vm.deal(address(vulnerableContract), 10 ether); // Fund the vulnerable contract
        attacker = new ReentrancyAttacker(address(vulnerableContract));
        vm.deal(address(attacker), 1 ether); // Fund the attacker
    }

    function testReentrancyAttack() public {
        // Launch the attack
        vm.prank(address(attacker));
        attacker.attack{value: 1 ether}();

        // Check the balances
        uint256 contractBalance = address(vulnerableContract).balance;
        uint256 attackerBalance = address(attacker).balance;

        emit log_named_uint("Vulnerable Contract Balance", contractBalance);
        emit log_named_uint("Attacker Balance", attackerBalance);

        // Assert that the vulnerable contract lost funds
        assert(contractBalance < 9 ether); // Should be drained
        assert(attackerBalance > 1 ether); // Attacker gains funds
    }
}
