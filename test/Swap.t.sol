// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";

import "../src/helpers/MOCKRWD.sol";
import "../src/helpers/MockWKD.sol";

//import "../src/helpers/IBEP20.sol";
import "../src/helpers/WETH.sol";
import {WakandaRouter} from "../src/swap/Router.sol";

import {WakandaFactory} from "../src/swap/Wakanda_pair.sol";

contract SwapTest is Test {
    MockREWARD mREWARD;
    MOCKWAKANDA mWAKANDA;

    WETH9 weth;

    WakandaFactory wFactory;

    WakandaRouter wRouter;
    address feeTo = mkaddr("feesto");

    function setUp() public {
        mWAKANDA = new MOCKWAKANDA();
        mREWARD = new MockREWARD();
        weth = new WETH9();
        mREWARD.setAddress(address(this));
        //deploy router and factory
        wFactory = new WakandaFactory(feeTo);
        wRouter = new WakandaRouter(address(wFactory), address(weth));
        mREWARD.approve(address(wRouter), 1000000e18);
        mWAKANDA.approve(address(wRouter), 1000000e18);
        wFactory.INIT_CODE_PAIR_HASH();
    }

    function testLiquidity() public {
        wRouter.addLiquidityETH{value: 10 ether}(
            address(mWAKANDA),
            100e18,
            0,
            10e18,
            address(this),
            block.timestamp + 3000
        );

        //try to swap
        address se = mkaddr("swapper");
        vm.startPrank(se);
        vm.deal(se, 10000000e18);
        wRouter.swapExactETHForTokens{value: 1 ether}(
            0,
            outt(address(weth), address(mWAKANDA)),
            address(this),
            block.timestamp + 3000
        );
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function outt(address a, address b)
        internal
        view
        returns (address[] memory add)
    {
        add = new address[](2);
        add[0] = a;
        add[1] = b;
    }
}
