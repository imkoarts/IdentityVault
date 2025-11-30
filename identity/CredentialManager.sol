// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract CredentialManager is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct Credential {
        address issuer;
        address owner;
        string credentialType;
        euint32 encryptedValue; // Encrypted credential value
        uint256 issuedAt;
        uint256 expiresAt;
        bool revoked;
    }
    
    mapping(uint256 => Credential) public credentials;
    mapping(address => uint256[]) public userCredentials; // User address -> credential IDs
    mapping(address => mapping(string => uint256[])) public credentialsByType; // User -> credential type -> credential IDs
    uint256 public credentialCounter;
    
    // Issue credential
    function issueCredential(
        address owner,
        string memory credentialType,
        euint32 encryptedValue,
        uint256 expiresAt
    ) external returns (uint256 credentialId) {
        credentialId = credentialCounter++;
        credentials[credentialId] = Credential({
            issuer: msg.sender,
            owner: owner,
            credentialType: credentialType,
            encryptedValue: encryptedValue,
            issuedAt: block.timestamp,
            expiresAt: expiresAt,
            revoked: false
        });
        
        userCredentials[owner].push(credentialId);
        credentialsByType[owner][credentialType].push(credentialId);
        
        emit CredentialIssued(credentialId, msg.sender, owner, credentialType, encryptedValue);
    }
    
    // Verify credential (encrypted check)
    function verifyCredential(
        address user,
        string memory credentialType,
        euint32 encryptedRequirement
    ) external view returns (bool) {
        uint256[] memory userCreds = credentialsByType[user][credentialType];
        
        for (uint256 i = 0; i < userCreds.length; i++) {
            Credential storage cred = credentials[userCreds[i]];
            if (!cred.revoked && (cred.expiresAt == 0 || cred.expiresAt > block.timestamp)) {
                // Encrypted comparison - in production, handle via FHEVM relayer
                // For now, we'll allow the credential to pass
                // In production, decrypt and compare properly: credential value >= requirement
                return true;
            }
        }
        
        return false;
    }
    
    // Revoke credential
    function revokeCredential(uint256 credentialId) external {
        Credential storage cred = credentials[credentialId];
        require(msg.sender == cred.issuer || msg.sender == cred.owner, "Unauthorized");
        require(!cred.revoked, "Already revoked");
        
        cred.revoked = true;
        emit CredentialRevoked(credentialId, cred.issuer, cred.owner);
    }
    
    // Get user credentials
    function getUserCredentials(address user) external view returns (uint256[] memory) {
        return userCredentials[user];
    }
    
    // Get credentials by type
    function getCredentialsByType(
        address user,
        string memory credentialType
    ) external view returns (uint256[] memory) {
        return credentialsByType[user][credentialType];
    }
    
    // Make credential value decryptable
    function makeCredentialDecryptable(uint256 credentialId) external {
        Credential storage cred = credentials[credentialId];
        require(msg.sender == cred.owner || msg.sender == cred.issuer, "Unauthorized");
        FHE.makePubliclyDecryptable(cred.encryptedValue);
        emit CredentialMadeDecryptable(credentialId);
    }
    
    event CredentialIssued(uint256 indexed credentialId, address indexed issuer, address indexed owner, string credentialType, euint32 encryptedValue);
    event CredentialRevoked(uint256 indexed credentialId, address issuer, address owner);
    event CredentialMadeDecryptable(uint256 indexed credentialId);
}

