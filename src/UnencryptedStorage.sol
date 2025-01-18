// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnencryptedStorage {
    string private secretKey;

    constructor(string memory _secretKey) {
        secretKey = _secretKey; // Sensitive data stored unencrypted
    }

    function getSecretKey() public pure returns (string memory) {
        return "Access Denied"; // Attempt to obscure access via the interface
    }
}
