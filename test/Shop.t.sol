// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {IERC20Errors} from "@openzeppelin/contracts/interfaces/draft-IERC6093.sol";
import {Shop} from "../src/Shop.sol";
import {USD} from "../src/USD.sol";
import {Magic} from "../src/Magic.sol";
contract ShopTest is Test {
    address owner = makeAddr("owner");

    USD public usd;
    Magic public magic; 
    Shop public shop;

    function setUp() public {
        vm.startPrank(owner);
        usd = new USD();
        magic = new Magic();
        shop = new Shop(usd, magic);

        magic.setShop(address(shop));
        vm.stopPrank();
    }

    function test_getTotalPrice_lessThan10() public view {
        uint256 quantity = 5;
        uint256 expectedPrice = 10000;

        assertEq(shop.getTotalPrice(quantity), expectedPrice);
    }

    function test_getTotalPrice_greaterThan10() public view {
        uint256 quantity = 15;
        uint256 expectedPrice = 29000; // 10 full price (=20000) + 5 discounted price (=10000 - 10% - 9000)

        assertEq(shop.getTotalPrice(quantity), expectedPrice);
    }

    function test_purchase_ok() public {
        address alice = makeAddr("alice");
        uint256 quantity = 5;
        uint256 expectedPrice = shop.getTotalPrice(quantity);

        usd.mint(alice, expectedPrice);

        vm.prank(alice);
        usd.approve(address(shop), expectedPrice);

        vm.prank(alice);
        shop.purchase(quantity);

        assertEq(usd.balanceOf(alice), 0);
        assertEq(usd.balanceOf(shop.owner()), expectedPrice);
        assertEq(magic.balanceOf(alice), quantity);
    }

    function test_purchase_notEnoughUSD() public {
        address alice = makeAddr("alice");
        uint256 quantity = 5;
        uint256 expectedPrice = shop.getTotalPrice(quantity);
        uint256 actualBalance = expectedPrice  - 1;

        usd.mint(alice, actualBalance);

        vm.prank(alice);
        usd.approve(address(shop), expectedPrice);

        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientBalance.selector, alice, actualBalance, expectedPrice));
        shop.purchase(quantity);

        assertEq(usd.balanceOf(alice), actualBalance);
        assertEq(usd.balanceOf(shop.owner()), 0);
        assertEq(magic.balanceOf(alice), 0);
    }
}