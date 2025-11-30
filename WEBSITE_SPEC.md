# WEBSITE_SPEC.md - IdentityVault (Encrypted Identity Verification Platform)

> **NOTE:** This file is for the frontend developer. After the website is created, this file can be deleted from the repository.

## General Description

IdentityVault is a blockchain-based identity verification platform with encrypted personal data and credentials. Users can verify their identity without revealing sensitive information.

## Website Structure

### Home Page (/)

**Header:**
- Logo "IdentityVault" (click → home)
- Navigation:
  - "My Identity" (click → /identity)
  - "Verifications" (click → /verifications)
  - "Credentials" (click → /credentials)
  - "Providers" (click → /providers)
- "Connect Wallet" button

**Hero:**
- Title: "Private Identity Verification"
- Subtitle: "Verify your identity without revealing personal data"
- Button "Get Started" (click → /identity)

**Features:**
- "Encrypted Storage" - personal data stays encrypted
- "Private Verification" - verification without data exposure
- "Credential Management" - encrypted credentials
- "Selective Disclosure" - share only what's needed

### Page "My Identity" (/identity)

**Identity Overview:**
- Verification Status (Verified/Unverified/Pending)
- Reputation Score (encrypted, shown as "***")
- Credentials Count
- Last Verification Date

**Register Identity:**
- Form to register identity:
  - Field "Age" (number, will be encrypted)
  - Field "Document Hash" (file upload, hash stored)
  - Field "Country" (dropdown)
  - Field "Document Type" (dropdown: Passport, ID, Driver's License)
  - Button "Encrypt & Register"
    - On click: encrypts age and registers identity
    - Shows "Registering identity..."
    - After success: "Identity registered successfully"
    - Redirects to /verifications

**Identity Details:**
- Age (encrypted, shown as "***", button "Decrypt")
- Document Hash (public)
- Verification Status
- Credentials List
- Button "Update Identity"

### Page "Verifications" (/verifications)

**Verification Requests:**
- List of verification requests:
  - Request ID
  - Requester (service provider)
  - Verification Type
  - Status (Pending/Approved/Rejected)
  - Requested Data (encrypted, shown as "***")
  - Button "Approve"
  - Button "Reject"
  - Button "View Details"

**My Verification Status:**
- Current verification level (encrypted)
- Verification history
- Pending requests
- Approved verifications

**Request Verification:**
- Form to request verification:
  - Field "Verification Type" (dropdown: KYC, Age Verification, etc.)
  - Field "Service Provider" (address)
  - Field "Required Data" (encrypted)
  - Button "Encrypt & Request"
    - On click: encrypts request and submits
    - Shows "Processing request..."
    - After success: "Verification requested"

### Page "Credentials" (/credentials)

**Credentials List:**
- Table of credentials:
  - Columns: Type, Issuer, Value (encrypted, shown as "***"), Issue Date, Expiry Date, Status, Actions
  - Button "Decrypt Credential"
  - Button "Share Credential"
  - Button "Revoke Credential"

**Issue Credential:**
- Form to issue new credential:
  - Field "Credential Type" (dropdown: Age, Qualification, etc.)
  - Field "Value" (number/text, will be encrypted)
  - Field "Expiry Date" (date)
  - Button "Encrypt & Issue"
    - On click: encrypts value and issues credential
    - Shows "Issuing credential..."
    - After success: "Credential issued successfully"

**Credential Details:**
- Full credential information
- Encrypted value shown as "***"
- Button "Decrypt Credential"
- Button "Share with Provider"
- Verification history

### Page "Providers" (/providers)

**Service Providers:**
- List of registered service providers:
  - Provider Name
  - Provider Address
  - Verification Types Supported
  - Reputation Score
  - Button "Request Verification"

**Request Verification from Provider:**
- Form to request verification:
  - Field "Provider Address" (address)
  - Field "Verification Type" (dropdown)
  - Field "Required Credentials" (multi-select)
  - Button "Send Request"
    - On click: sends verification request
    - Shows "Sending request..."
    - After success: "Request sent"

**Provider Dashboard (for service providers):**
- List of verification requests
- Eligibility checks (encrypted)
- Verification results
- Statistics (encrypted)

## Common UI Elements

### Modals

**Modal "Identity Details":**
- Full identity information
- Encrypted age shown as "***"
- Button "Decrypt Age"
- Verification status
- Button "Close"

**Modal "Verification Request":**
- Request details
- Encrypted required data shown as "***"
- Buttons: "Approve", "Reject", "Close"

**Modal "Credential Share":**
- Select provider
- Select credentials to share
- Encrypted values shown as "***"
- Buttons: "Share", "Cancel"

### Notifications
- "Identity registered successfully" (green)
- "Verification approved" (success)
- "Credential issued" (info)
- "Verification request received" (info)

### Loading
- "Encrypting identity..."
- "Processing verification..."
- "Issuing credential..."
- "Decrypting data..."

## Navigation
- `/` - Home
- `/identity` - My identity
- `/verifications` - Verifications
- `/credentials` - Credentials
- `/providers` - Service providers

## Design
- Security/trust theme
- Professional design
- Privacy-focused UI
- Clear verification status indicators
- Responsive design

## Technical Requirements
- Web3 wallet integration (MetaMask only)
- Zama FHEVM for identity/credential encryption
- Display encrypted data as "***"
- Verification mechanism
- Credential management system
- Selective disclosure functionality
- Decryption on request for authorized parties

