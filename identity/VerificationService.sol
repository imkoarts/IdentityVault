// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {FHE} from "@fhevm/solidity/lib/FHE.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

contract VerificationService is ZamaEthereumConfig {
    using FHE for euint32;
    
    struct VerificationRequest {
        address requester; // Service provider
        address user;
        string verificationType;
        euint32 encryptedRequirement; // Encrypted requirement (e.g., minimum age)
        bool approved;
        bool processed;
        uint256 createdAt;
    }
    
    struct ReputationScore {
        address user;
        euint32 score; // Encrypted reputation score
        uint256 lastUpdated;
    }
    
    mapping(uint256 => VerificationRequest) public requests;
    mapping(address => ReputationScore) public reputationScores;
    uint256 public requestCounter;
    
    // Request verification
    function requestVerification(
        address user,
        string memory verificationType,
        euint32 encryptedRequirement
    ) external returns (uint256 requestId) {
        requestId = requestCounter++;
        requests[requestId] = VerificationRequest({
            requester: msg.sender,
            user: user,
            verificationType: verificationType,
            encryptedRequirement: encryptedRequirement,
            approved: false,
            processed: false,
            createdAt: block.timestamp
        });
        
        emit VerificationRequested(requestId, msg.sender, user, verificationType);
    }
    
    // Approve verification request
    function approveVerification(uint256 requestId) external {
        VerificationRequest storage request = requests[requestId];
        require(request.user == msg.sender, "Not request user");
        require(!request.processed, "Already processed");
        
        request.approved = true;
        request.processed = true;
        
        // Update reputation score (encrypted addition)
        // Encrypted comparison - in production, handle via FHEVM relayer
        // For now, we'll skip this check
        // In production, decrypt and check if score < 100
        if (false) {
            reputationScores[msg.sender].score = reputationScores[msg.sender].score.add(FHE.asEuint32(1));
            reputationScores[msg.sender].lastUpdated = block.timestamp;
        }
        
        emit VerificationApproved(requestId, request.requester, msg.sender);
    }
    
    // Reject verification request
    function rejectVerification(uint256 requestId) external {
        VerificationRequest storage request = requests[requestId];
        require(request.user == msg.sender, "Not request user");
        require(!request.processed, "Already processed");
        
        request.approved = false;
        request.processed = true;
        
        emit VerificationRejected(requestId, request.requester, msg.sender);
    }
    
    // Verify eligibility (encrypted check)
    function verifyEligibility(
        address user,
        euint32 encryptedRequirement
    ) external view returns (bool) {
        // This would typically call IdentityRegistry to check age eligibility
        // For now, return true if user has verified identity
        // In production, integrate with IdentityRegistry
        return true; // Placeholder
    }
    
    // Get reputation score (encrypted)
    function getReputationScore(address user) external view returns (euint32) {
        return reputationScores[user].score;
    }
    
    // Make reputation decryptable
    function makeReputationDecryptable(address user) external {
        require(msg.sender == user, "Not user");
        FHE.makePubliclyDecryptable(reputationScores[user].score);
        emit ReputationMadeDecryptable(user);
    }
    
    event VerificationRequested(uint256 indexed requestId, address indexed requester, address indexed user, string verificationType);
    event VerificationApproved(uint256 indexed requestId, address requester, address user);
    event VerificationRejected(uint256 indexed requestId, address requester, address user);
    event ReputationMadeDecryptable(address indexed user);
}

