// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {USD} from "../src/USD.sol";

contract USDTest is Test {
    USD public usd;

    function setUp() public {
        usd = new USD();
    }

    function test_decimals() public view {
        assertEq(usd.decimals(), 2);
    }

    function test_mint_self() public {
        address alice = makeAddr("Alice");

        vm.prank(alice);
        usd.mint(alice, 100);
        assertEq(usd.balanceOf(alice), 100);
    }

    function test_mint_other() public {
        address alice = makeAddr("Alice");
        address bob = makeAddr("Bob");

        vm.prank(alice);
        usd.mint(bob, 100);
        assertEq(usd.balanceOf(alice), 0);
        assertEq(usd.balanceOf(bob), 100);
    }
}