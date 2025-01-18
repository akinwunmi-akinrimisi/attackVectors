// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReplayVulnerable {
    mapping(address => uint256) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
        balances[msg.sender] = 1000; // Assign some initial balance to the owner
    }

    function transfer(
        address to,
        uint256 amount,
        uint256 nonce,
        bytes memory signature
    ) public {
        bytes32 messageHash = keccak256(
            abi.encodePacked(msg.sender, to, amount, nonce)
        );

        address signer = recoverSigner(messageHash, signature);
        require(signer == owner, "Invalid signature");

        require(balances[signer] >= amount, "Insufficient balance");
        balances[signer] -= amount;
        balances[to] += amount;
    }

    function recoverSigner(bytes32 messageHash, bytes memory signature)
        public
        pure
        returns (address)
    {
        bytes32 ethSignedMessageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash)
        );
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        return ecrecover(ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory sig)
        public
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(sig.length == 65, "Invalid signature length");
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}
