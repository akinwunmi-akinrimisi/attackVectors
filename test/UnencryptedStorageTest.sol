// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/UnencryptedStorage.sol";

contract UnencryptedStorageTest is Test {
    UnencryptedStorage public unencryptedStorage;

    function setUp() public {
        unencryptedStorage = new UnencryptedStorage("my-super-secret-key");
    }

    function testExtractSecretKey() public {
        // Simulate reading the storage slot
        bytes32 secretKeySlot = vm.load(address(unencryptedStorage), bytes32(uint256(0))); // Slot 0 for "secretKey"
        emit log(string(abi.encodePacked("Extracted Secret Key: ", secretKeySlot)));
    }
}
