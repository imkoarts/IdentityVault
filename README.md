# IdentityVault - Encrypted Identity Verification Platform

## Description

IdentityVault is a blockchain-based identity verification platform where personal data, verification status, and credentials remain encrypted. Users can verify their identity without revealing sensitive information, and service providers can verify eligibility without accessing full personal data.

## Functionality

- Encrypted identity document storage
- Private KYC/AML verification
- Confidential credential management
- Encrypted age and eligibility verification
- Private reputation scoring
- Public decryption for authorized verification

## Smart Contracts

- `IdentityRegistry.sol` - Main contract for identity management
- `VerificationService.sol` - Contract for encrypted verification processing
- `CredentialManager.sol` - Contract for private credential storage

## UI/UX

### User Dashboard
- Form to upload identity documents (encrypted)
- Verification status (encrypted)
- Credential management (encrypted)
- Reputation score (encrypted)
- Verification history

### Service Provider Dashboard
- Request identity verification (without seeing data)
- Verify eligibility (encrypted checks)
- View verification status
- Request specific credentials (encrypted)

### Verification Interface
- Document upload with encryption
- Verification process tracking
- Credential issuance
- Access control management

## Technical Requirements

- **Technology Stack:**
  - Zama FHEVM v0.9
  - Next.js 16 (App Router)
  - React 19
  - TypeScript
  - Tailwind CSS
  - Wagmi v3 (MetaMask only, using `injected()` connector)
  - Ethers.js v6.8.0
  - @zama-fhe/relayer-sdk v0.3.0

- **Network:** Sepolia Testnet
- **Relayer:** https://relayer.testnet.zama.org

## Deployed Contract Addresses

- **IDENTITY_REGISTRY**: `0xD04462a29deC4C49E3Df79431Ca461656cAAde28` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0xD04462a29deC4C49E3Df79431Ca461656cAAde28))
- **VERIFICATION_SERVICE**: `0xCe0E999cF526cc59159e1b1ab2e7c3DD6b40e7c9` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0xCe0E999cF526cc59159e1b1ab2e7c3DD6b40e7c9))
- **CREDENTIAL_MANAGER**: `0x92672DBFb92D37BbCB7DEa5C7DaA4C1F716cC20f` ([Sepolia Etherscan](https://sepolia.etherscan.io/address/0x92672DBFb92D37BbCB7DEa5C7DaA4C1F716cC20f))

## Environment Variables

```env
NEXT_PUBLIC_CHAIN_ID=11155111
NEXT_PUBLIC_RPC_URL=https://sepolia.gateway.tenderly.co
NEXT_PUBLIC_RELAYER_URL=https://relayer.testnet.zama.org
NEXT_PUBLIC_IDENTITY_REGISTRY_ADDRESS=0xD04462a29deC4C49E3Df79431Ca461656cAAde28
NEXT_PUBLIC_VERIFICATION_SERVICE_ADDRESS=0xCe0E999cF526cc59159e1b1ab2e7c3DD6b40e7c9
NEXT_PUBLIC_CREDENTIAL_MANAGER_ADDRESS=0x92672DBFb92D37BbCB7DEa5C7DaA4C1F716cC20f
```

## Deployment

1. Deploy smart contracts to Sepolia
2. Update `contracts.json` with deployed addresses
3. Configure environment variables
4. Deploy frontend to Vercel

## API Functions

**IdentityRegistry:**
- `registerIdentity(euint32 encryptedAge, bytes32 documentHash)` - Register identity
- `updateVerificationStatus(address user, bool verified)` - Update verification status
- `getVerificationStatus(address user)` - Get verification status

**VerificationService:**
- `requestVerification(address user, string verificationType)` - Request verification
- `verifyEligibility(address user, euint32 encryptedRequirement)` - Verify eligibility (encrypted)
- `getReputationScore(address user)` - Get reputation score (encrypted)

**CredentialManager:**
- `issueCredential(address user, string credentialType, euint32 encryptedValue)` - Issue credential
- `verifyCredential(address user, string credentialType)` - Verify credential (encrypted)
- `revokeCredential(address user, string credentialType)` - Revoke credential

