// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";

import "../src/helpers/MOCKRWD.sol";
import "../src/helpers/MockWKD.sol";
import "../src/helpers/IBEP20.sol";

import "../src/farm/WKLDLPPool.sol";

contract StakingTest is Test {
    MockREWARD mREWARD;
    MOCKWAKANDA mWAKANDA;
    WKDLPPool lpS;

    function setUp() public {
        mWAKANDA = new MOCKWAKANDA();
        mREWARD = new MockREWARD();
        lpS = new WKDLPPool(IBEP20(address(mREWARD)));
        //send in rewards
        mREWARD.setAddress(address(lpS));
        //create a pool
        lpS.add(3, IBEP20(address(mWAKANDA)), true, true);

        lpS.wkdPerBlock(true);
        address staker1 = mkaddr("staker1");
        address staker2 = mkaddr("staker2");
        //send some lptokens to staker1 and staker2

        mWAKANDA.transfer(staker1, 100e18);
        mWAKANDA.transfer(staker2, 100e18);

        vm.startPrank(staker1);
        mWAKANDA.approve(address(lpS), 1000000000000e18);
        lpS.deposit(0, 100e18);
        // mREWARD.setAddress(newPool);
        vm.stopPrank();

        vm.startPrank(staker2);
        mWAKANDA.approve(address(lpS), 1000000000000e18);
        lpS.deposit(0, 99e18);
        // mREWARD.setAddress(newPool);
        vm.stopPrank();
        //jump by a block
        vm.roll(2);
        lpS.pendingWkd(0, staker1);
        vm.prank(staker1);
        lpS.pendingWkd(0, staker2);
        // //try to stake some WKD
        vm.prank(staker2);
        lpS.deposit(0, 0);

        // lpS.add(3, IBEP20(address(mWAKANDA)), true, true);
        // mWAKANDA.approve(newPool, 10000e18);
        // WakandaPoolInitializable pool = WakandaPoolInitializable(newPool);
        // pool.deposit(100e18);
        // address secondStaker = mkaddr("Second Staker");
        // //send some WKD to another address
        // mWAKANDA.transfer(secondStaker, 100e18);

        // vm.prank(secondStaker);
        // mWAKANDA.approve(newPool, 10000e18);
        // vm.prank(secondStaker);
        // pool.deposit(100e18);
        // //check rewards
        // pool.pendingReward(address(this));
        // pool.pendingReward(secondStaker);

        // //go to 50 blocks(40 blocks of reward)
        // vm.roll(51);
        // uint256 pending = pool.pendingReward(address(this));
        // assertEq(pending, (10e18 * 40) / 2);
        // pool.withdraw(400e18);
        // pool.pendingReward(address(this));
        // pool.withdraw(400e18);
    }

    function testExample() public {
        assertTrue(true);
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
