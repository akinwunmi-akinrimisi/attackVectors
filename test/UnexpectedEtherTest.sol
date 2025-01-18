// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/UnexpectedEther.sol";
import "../src/EtherBomb.sol";

contract UnexpectedEtherTest is Test {
    UnexpectedEther public unexpectedEther;

    function setUp() public {
        unexpectedEther = new UnexpectedEther();
        vm.deal(address(this), 10 ether); // Fund the test contract
    }

    function testUnexpectedEtherAttack() public {
        // Deposit some Ether into the vulnerable contract
        unexpectedEther.deposit{value: 2 ether}();

        // Deploy the EtherBomb contract and send unexpected Ether
        new EtherBomb{value: 3 ether}(payable(address(unexpectedEther)));

        // Check the contract's reported balance
        uint256 reportedBalance = unexpectedEther.getContractBalance();
        emit log_named_uint("Contract Balance After Attack", reportedBalance);

        // The reported balance is now inflated
        assertEq(reportedBalance, 5 ether); // 2 ether deposit + 3 ether from EtherBomb

        // Try to withdraw funds
        vm.expectRevert("Insufficient balance");
        unexpectedEther.withdraw(5 ether); // Withdrawal fails because internal balance is not updated
    }
}
