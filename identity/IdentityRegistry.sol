// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract IdentityRegistry is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct Identity {
        address owner;
        euint32 age; // Encrypted age
        bytes32 documentHash; // Hash of identity document
        string country;
        string documentType;
        bool verified;
        uint256 registeredAt;
        uint256 lastVerifiedAt;
    }
    
    mapping(address => Identity) public identities;
    mapping(address => bool) public isRegistered;
    
    // Register identity
    function registerIdentity(
        euint32 encryptedAge,
        bytes32 documentHash,
        string memory country,
        string memory documentType
    ) external {
        require(!isRegistered[msg.sender], "Already registered");
        
        identities[msg.sender] = Identity({
            owner: msg.sender,
            age: encryptedAge,
            documentHash: documentHash,
            country: country,
            documentType: documentType,
            verified: false,
            registeredAt: block.timestamp,
            lastVerifiedAt: 0
        });
        
        isRegistered[msg.sender] = true;
        emit IdentityRegistered(msg.sender, documentHash, country);
    }
    
    // Update verification status (admin/verifier function)
    function updateVerificationStatus(
        address user,
        bool verified
    ) external {
        require(isRegistered[user], "Identity not registered");
        // In production, add access control for verifiers
        
        identities[user].verified = verified;
        if (verified) {
            identities[user].lastVerifiedAt = block.timestamp;
        }
        
        emit VerificationStatusUpdated(user, verified);
    }
    
    // Get verification status
    function getVerificationStatus(address user) external view returns (bool) {
        return identities[user].verified;
    }
    
    // Make age decryptable
    function makeAgeDecryptable(address user) external {
        require(msg.sender == user || identities[user].verified, "Unauthorized");
        FHE.makePubliclyDecryptable(identities[user].age);
        emit AgeMadeDecryptable(user);
    }
    
    // Check age eligibility (encrypted comparison)
    function checkAgeEligibility(
        address user,
        euint32 encryptedMinimumAge
    ) external view returns (bool) {
        Identity storage identity = identities[user];
        require(isRegistered[user], "Identity not registered");
        
        // Encrypted comparison: age >= minimumAge
        // Encrypted comparison - in production, handle via FHEVM relayer
        // For now, we'll return true (age >= minimumAge)
        // In production, decrypt and compare properly: !(age < minimumAge)
        return true;
    }
    
    event IdentityRegistered(address indexed user, bytes32 documentHash, string country);
    event VerificationStatusUpdated(address indexed user, bool verified);
    event AgeMadeDecryptable(address indexed user);
}

