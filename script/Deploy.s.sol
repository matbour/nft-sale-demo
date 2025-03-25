// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {USD} from "../src/USD.sol";
import {Magic} from "../src/Magic.sol";
import {Shop} from "../src/Shop.sol";

contract Deploy is Script {
    function run() public {
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        USD usd = new USD();
        Magic magic = new Magic();
        Shop shop = new Shop(usd, magic);
        magic.setShop(address(shop));
        vm.stopBroadcast();
    }
}