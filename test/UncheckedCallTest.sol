// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/UncheckedCall.sol";
import "../src/malicious.sol";

contract UncheckedCallTest is Test {
    UncheckedCall public uncheckedCall;
    Malicious public malicious;

    function setUp() public {
        uncheckedCall = new UncheckedCall();
        malicious = new Malicious(address(uncheckedCall));

        // Fund the vulnerable contract
        vm.deal(address(uncheckedCall), 10 ether);
        vm.deal(address(malicious), 1 ether);
    }

    function testUncheckedCallExploit() public {
        // Attack by calling the malicious contract
        vm.prank(address(malicious));
        malicious.attack();

        // Assert the vulnerable contract lost funds
        uint256 contractBalance = address(uncheckedCall).balance;
        emit log_named_uint("Vulnerable Contract Balance", contractBalance);

        assert(contractBalance < 10 ether);
    }
}
