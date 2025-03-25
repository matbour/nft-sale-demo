// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title USD Token Contract
/// @notice A simple ERC20 token representing USD with 2 decimal places
/// @dev Used as the payment token for purchasing Magic NFTs
contract USD is ERC20 {
    /// @notice Initializes the USD token with name "USD" and symbol "USD"
    constructor() ERC20("USD", "USD") {}

    /// @notice Returns the number of decimal places used by the token
    /// @dev Overrides the default 18 decimals to use 2 decimals like real USD
    /// @return The number of decimal places (2)
    function decimals() public pure override returns (uint8) {
        return 2;
    }

    /// @notice Mints new USD tokens to a specified address
    /// @dev Can be called by any external account to create new tokens
    /// @param to The address to receive the newly minted tokens
    /// @param amount The amount of tokens to mint
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}