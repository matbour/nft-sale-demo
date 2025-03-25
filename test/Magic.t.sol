// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Magic} from "../src/Magic.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MagicTest is Test {
    address owner = makeAddr("owner");
    address shop = makeAddr("shop");
    Magic public magic;

    function setUp() public {
        vm.startPrank(owner);
        magic = new Magic();
        magic.setShop(shop);
        vm.stopPrank();
    }

    function test_constructor() public view {
        assertEq(magic.name(), "Magic");
        assertEq(magic.symbol(), "MAGIC");
        assertEq(magic.owner(), owner);
    }
    
    function test_setShop_asOwner() public {
        address newShop = makeAddr("newShop");

        vm.prank(owner);
        magic.setShop(newShop);

        assertEq(magic.shop(), newShop);
    }

    function test_setShop_asNotOwner() public {
        address newShop = makeAddr("newShop");
        address notOwner = makeAddr("notOwner");

        vm.prank(notOwner);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, notOwner));
        magic.setShop(newShop);
        assertEq(magic.shop(), shop);
    }

    function test_mintTo_asShop() public {
        address alice = makeAddr("alice");
        uint256 quantity = 10;

        vm.prank(shop);
        magic.mintTo(alice, quantity);
        assertEq(magic.balanceOf(alice), quantity);
    }

    function test_mintTo_asNotShop() public {
        address alice = makeAddr("alice");
        uint256 quantity = 10;

        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Magic.NotShop.selector));
        magic.mintTo(alice, quantity);

        assertEq(magic.balanceOf(alice), 0);
    }
}