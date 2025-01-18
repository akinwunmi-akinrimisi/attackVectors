// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/LongArrayLoop.sol";

contract LongArrayLoopTest is Test {
    LongArrayLoop public longArrayLoop;

    function setUp() public {
        longArrayLoop = new LongArrayLoop();

        // Add many recipients to simulate a large array
        for (uint256 i = 0; i < 200; i++) {
            longArrayLoop.addRecipient(address(uint160(i + 1)));
        }
    }

    function testDistributeFunds() public {
        vm.deal(address(this), 10 ether);

        // Attempt to distribute funds to all recipients
        vm.expectRevert(); // Expect failure due to gas limitations
        longArrayLoop.distributeFunds{value: 10 ether}();
    }
}
