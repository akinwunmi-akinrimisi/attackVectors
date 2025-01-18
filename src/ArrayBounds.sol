// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayBounds {
    uint256[] public numbers;

    function addNumber(uint256 _number) public {
        numbers.push(_number);
    }

    function getNumber(uint256 index) public view returns (uint256) {
        // Vulnerability: No check to ensure index is within bounds
        return numbers[index];
    }
}
