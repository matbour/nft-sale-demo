# NFT Sale Demo

A simple NFT sale system implemented on Polygon Amoy testnet, featuring a Magic NFT collection that can be purchased using a custom USD token.

## Overview

This project demonstrates a basic NFT sale system with the following components:
- A Magic NFT collection (ERC721)
- A custom USD token (ERC20) with 2 decimal places
- A Shop contract that manages the sale of Magic NFTs using USD tokens
- A discount system for bulk purchases

## Contract Addresses

### Polygon Amoy Testnet

- **Magic NFT Contract**: [0x4bbF870177f98cF4c08F50396747F53dD2D765e0](https://amoy.polygonscan.com/address/0x4bbF870177f98cF4c08F50396747F53dD2D765e0)
- **USD Token Contract**: [0xEd61C6c2506e637180a7f624fF01691695D4c24D](https://amoy.polygonscan.com/address/0xEd61C6c2506e637180a7f624fF01691695D4c24D)
- **Shop Contract**: [0xda849cd5fc27Cc1E6BFF1b891ca548dC29F6360E](https://amoy.polygonscan.com/address/0xda849cd5fc27Cc1E6BFF1b891ca548dC29F6360E)

## Features

### Magic NFT (ERC721)
- Unique Magic NFTs that can be purchased through the Shop
- Controlled minting system where only the Shop contract can mint new tokens
- Sequential token IDs starting from 0

### USD Token (ERC20)
- Custom USD token with 2 decimal places
- Used as the payment token for purchasing Magic NFTs
- Simple minting functionality for testing purposes

### Shop Contract
- Manages the sale of Magic NFTs using USD tokens
- Implements a discount system:
  - Base price: 20 USD per NFT
  - Discount: 10% off per additional NFT for purchases over 10 NFTs
- Example pricing:
  - 1 NFT: 20 USD
  - 10 NFTs: 200 USD
  - 11 NFTs: 209 USD (10% discount on the 11th NFT)
  - 20 NFTs: 380 USD (10% discount on NFTs 11-20)

## Technical Details

### Contract Deployment
- Network: Polygon Amoy Testnet
- Block: 19635450
- Total Gas Used: 3,634,459
- Average Gas Price: 37.5 gwei
- Total Cost: 0.136292212554516885 ETH

### Transaction Hashes
1. Magic NFT Deployment: [0x7589109c6acab9468da497ff7610876e781a45f18055f6cd47815bc85a7a45d6](https://amoy.polygonscan.com/tx/0x7589109c6acab9468da497ff7610876e781a45f18055f6cd47815bc85a7a45d6)
2. USD Token Deployment: [0xf9b35252ab7c1bf7a7a722544737e96214e4bf9df38e90a54c059c2a7060853e](https://amoy.polygonscan.com/tx/0xf9b35252ab7c1bf7a7a722544737e96214e4bf9df38e90a54c059c2a7060853e)
3. Shop Contract Deployment: [0x752f6a5d1eeed4f04a7ccb019f99b1f2aa917ba2d8db59fe12dd33b5c29dde14](https://amoy.polygonscan.com/tx/0x752f6a5d1eeed4f04a7ccb019f99b1f2aa917ba2d8db59fe12dd33b5c29dde14)

## Development

This project is built using:
- Solidity ^0.8.0
- OpenZeppelin Contracts
- Foundry for development and testing

## License

MIT