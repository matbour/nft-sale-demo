// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {USD} from "./USD.sol";
import {Magic} from "./Magic.sol";

/// @title Shop Contract
/// @notice A contract that manages the sale of Magic NFTs using USD tokens
/// @dev Implements a discount system for bulk purchases
contract Shop is Ownable {
    /// @notice The USD token contract used for payments
    USD public usd;
    
    /// @notice The Magic NFT contract that will be minted
    Magic public magic;
    
    /// @notice The base price for a single Magic NFT in USD (with 2 decimals)
    uint256 public immutable price;

    /// @notice Initializes the Shop contract with USD and Magic token contracts
    /// @param newUSD The address of the USD token contract
    /// @param newMagic The address of the Magic NFT contract
    constructor(USD newUSD, Magic newMagic) Ownable(msg.sender) {
        usd = newUSD;
        magic = newMagic;
        price = 20 * 10 ** usd.decimals();
    }

    /// @notice Calculates the total price for a given quantity of Magic NFTs
    /// @dev Implements a discount system where purchases over 10 NFTs receive a 10% discount per additional NFT
    /// @param quantity The number of Magic NFTs to purchase
    /// @return The total price in USD (with 2 decimals)
    function getTotalPrice(uint256 quantity) public view returns (uint256) {
        uint256 base = price * quantity;
        if (quantity <= 10) {
            return base;
        }

        uint256 discount = (quantity - 10) * price / 10;
        return base - discount;
    }

    /// @notice Purchases Magic NFTs using USD tokens
    /// @dev Transfers USD tokens from the buyer to the shop owner and mints Magic NFTs to the buyer
    /// @param quantity The number of Magic NFTs to purchase
    function purchase(uint256 quantity) external {
        usd.transferFrom(msg.sender, owner(), getTotalPrice(quantity));
        magic.mintTo(msg.sender, quantity);
    }
}
