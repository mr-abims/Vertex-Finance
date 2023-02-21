// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import "../src/farms/GeneralPoolFactory.sol";

import "forge-std/Script.sol";

contract WKDGeneralPool is Script {
    address WKD = 0x5344C20FD242545F31723689662AC12b9556fC3d;
    address deployer = 0xDcfa0d5C162660A9D7F93C62e6c5139663253270;
    // uint256 constant wkdPerBlock = 308_641e9; //800b wkd in 3 months

    GeneralPoolFactory gFactory;

    function setUp() public {}

    function run() public {
        vm.broadcast(deployer);
        gFactory = new GeneralPoolFactory();
        vm.stopBroadcast();
    }
}
