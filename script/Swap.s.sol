// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
import {WakandaRouter} from "../src/swap/Router.sol";

import {WakandaFactory} from "../src/swap/Wakanda_pair.sol";

import "forge-std/Script.sol";

contract SwapDeployment is Script {
    WakandaFactory wkFactory;
    WakandaRouter wkRouter;
    address WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address FEETO=0x84a71d3375F811e3c3D899135Ae188D98Eccd924;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        wkFactory = new WakandaFactory(FEETO);
        vm.stopBroadcast();
        vm.broadcast();
        wkRouter = new WakandaRouter(address(wkFactory), WBNB);
        vm.stopBroadcast();
    }
}
