// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
import {WKDLPPool} from "../src/farm/WKLDLPPool.sol";
import "../src/helpers/IBEP20.sol";

import "forge-std/Script.sol";

contract StakeDeployment is Script {
    WKDLPPool lpS;
    // address LPToken = 0x247Cd1273153BBF85a656781a815E92b422D1768;
    address WKD = 0x5344C20FD242545F31723689662AC12b9556fC3d;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        lpS = new WKDLPPool(IBEP20(WKD));
        vm.stopBroadcast();
        // vm.broadcast();
        // lpS.add(10, IBEP20(address(LPToken)), true, true);
    }
}
