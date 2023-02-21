// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import "../src/farm/GenericStakeFactory.sol";

import "forge-std/Script.sol";

contract WKDStake is Script {
    address WKD = 0x5344C20FD242545F31723689662AC12b9556fC3d;
    address deployer = 0xDcfa0d5C162660A9D7F93C62e6c5139663253270;
    uint256 constant wkdPerBlock = 308_641e9; //800b wkd in 3 months

    GenericStakeFactory gFactory;

    function setUp() public {}

    function run() public {
        vm.broadcast(deployer);
        gFactory = new GenericStakeFactory();
        vm.stopBroadcast();
        vm.broadcast(deployer);
        gFactory.deployPool(
            IBEP20(WKD),
            IBEP20(WKD),
            wkdPerBlock,
            block.number + 1 days,
            block.number + 6000 days, //6000 days
            0,
            deployer
        );
        vm.stopBroadcast();
    }
}
