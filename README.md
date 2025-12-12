# NFT Collection Smart Contract

This repository contains a fully functional ERC-721 NFT smart contract, a comprehensive automated test suite, and a Dockerized environment for easy setup and testing.

---

## **Project Overview**

The `NftCollection` contract is an ERC-721 compatible NFT collection that supports:

- Minting unique NFTs with a maximum supply.
- Safe transfers between addresses.
- Per-token and base URI metadata.
- Owner-only administrative actions.
- Pause/unpause minting functionality.
- Full support for approvals and operator mechanics.

This project is fully Dockerized so that anyone can build, test, and interact with the contract without installing dependencies locally.

---

## **Project Structure**

project-root/
├── contracts/
│ └── NftCollection.sol # Main ERC-721 smart contract
├── test/
│ └── NftCollection.test.js # Automated test suite
├── package.json # Node project dependencies
├── hardhat.config.js # Hardhat configuration
├── Dockerfile # Docker container definition
├── .dockerignore # Optional Docker ignore file
└── README.md # Project overview and instructions


---

## **Prerequisites**

- Docker installed on your system.  
- No need to install Node.js or Hardhat locally – everything runs inside the Docker container.

> **Note:** Node.js v16.x is used in the Docker container to ensure compatibility with Hardhat.

---

## **Building the Docker Container**

From the project root, run:

```bash
docker build --no-cache -t nft-contract .
