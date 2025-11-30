import { ethers } from "hardhat";
import * as dotenv from "dotenv";

dotenv.config();

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts...");
  const balance = await ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", ethers.formatEther(balance), "ETH");

  // Deploy IdentityRegistry
  console.log("\nDeploying IdentityRegistry...");
  const IdentityRegistry = await ethers.getContractFactory("IdentityRegistry");
  const identityRegistry = await IdentityRegistry.deploy();
  await identityRegistry.waitForDeployment();
  const identityRegistryAddress = await identityRegistry.getAddress();
  console.log("IdentityRegistry deployed to:", identityRegistryAddress);

  // Deploy VerificationService
  console.log("\nDeploying VerificationService...");
  const VerificationService = await ethers.getContractFactory("VerificationService");
  const verificationService = await VerificationService.deploy();
  await verificationService.waitForDeployment();
  const verificationServiceAddress = await verificationService.getAddress();
  console.log("VerificationService deployed to:", verificationServiceAddress);

  // Deploy CredentialManager
  console.log("\nDeploying CredentialManager...");
  const CredentialManager = await ethers.getContractFactory("CredentialManager");
  const credentialManager = await CredentialManager.deploy();
  await credentialManager.waitForDeployment();
  const credentialManagerAddress = await credentialManager.getAddress();
  console.log("CredentialManager deployed to:", credentialManagerAddress);

  // Summary
  console.log("\n" + "=".repeat(60));
  console.log("Deployment Summary");
  console.log("=".repeat(60));
  console.log("IDENTITY_REGISTRY:", identityRegistryAddress);
  console.log("VERIFICATION_SERVICE:", verificationServiceAddress);
  console.log("CREDENTIAL_MANAGER:", credentialManagerAddress);
  console.log("=".repeat(60));

  // Save addresses to .env format
  console.log("\nAdd these to your .env file:");
  console.log(`IDENTITY_REGISTRY_ADDRESS=${identityRegistryAddress}`);
  console.log(`VERIFICATION_SERVICE_ADDRESS=${verificationServiceAddress}`);
  console.log(`CREDENTIAL_MANAGER_ADDRESS=${credentialManagerAddress}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

