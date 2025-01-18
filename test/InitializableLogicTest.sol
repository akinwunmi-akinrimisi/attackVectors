// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VulnerableImplementation.sol";
import "../src/Proxy.sol";

contract InitializableLogicTest is Test {
    VulnerableImplementation public implementation;
    Proxy public proxy;

    address public attacker = address(0x1234);

    function setUp() public {
        implementation = new VulnerableImplementation();
        proxy = new Proxy(address(implementation));
    }

    function testUnprotectedInitialization() public {
        // Attacker initializes the logic contract directly
        vm.prank(attacker);
        implementation.initialize(attacker);

        // Check that the attacker is now the owner of the implementation contract
        assertEq(implementation.owner(), attacker);

        emit log_named_address("Implementation Owner", implementation.owner());
    }
}
