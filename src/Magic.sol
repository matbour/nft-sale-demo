// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title Magic NFT Contract
/// @notice An ERC721 token representing Magic NFTs that can be purchased through the Shop
/// @dev Implements a controlled minting system where only the Shop contract can mint new tokens
contract Magic is ERC721, Ownable {
    /// @notice The address of the Shop contract that can mint new tokens
    address public shop;
    
    /// @notice The next token ID to be minted
    uint public nextTokenId;

    /// @notice Error thrown when a non-shop address attempts to mint tokens
    error NotShop();

    /// @notice Initializes the Magic NFT contract with name "Magic" and symbol "MAGIC"
    constructor() ERC721("Magic", "MAGIC") Ownable(msg.sender) {}

    /// @notice Modifier that restricts function access to only the Shop contract
    /// @dev Throws NotShop error if called by any address other than the Shop contract
    modifier onlyShop() {
        if (msg.sender != shop) {
            revert NotShop();
        }
        _;
    }

    /// @notice Sets the address of the Shop contract that can mint new tokens
    /// @dev Can only be called by the contract owner
    /// @param newShop The address of the new Shop contract
    function setShop(address newShop) external onlyOwner {
        shop = newShop;
    }

    /// @notice Mints a specified quantity of Magic NFTs to a given address
    /// @dev Can only be called by the Shop contract
    /// @param to The address to receive the newly minted NFTs
    /// @param quantity The number of NFTs to mint
    function mintTo(address to, uint256 quantity) external onlyShop {
        for (uint256 i = 0; i < quantity; i++) {
            _mint(to, nextTokenId);
            nextTokenId++;
        }
    }
}
