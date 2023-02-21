pragma solidity 0.6.12;
import "forge-std/Test.sol";
import "../src/helpers/MockWKD.sol";
import "../src/helpers/IBEP20.sol";
import "../src/farm/GenericStakeFactory.sol";
import "../src/farm/GenericStake.sol";

contract GStakingTest is Test {
    GenericStakeFactory gFactory;
    WakandaPoolInitializable gStake;
    MOCKWAKANDA mWAKANDA;

    address user1;
    address user2;
    address user3;
    address admin;

    address wakandaAddress;
    address newPool;

    uint256 constant depositValue = 100_000e9;
    uint256 constant wkdPerBlock = 154_320e9;

    function setUp() public {
        mWAKANDA = new MOCKWAKANDA();
        gFactory = new GenericStakeFactory();
        wakandaAddress = address(mWAKANDA);

        admin = mkaddr("admin");
        user1 = mkaddr("user1");
        user2 = mkaddr("user2");
        user3 = mkaddr("user3");

        //deploy a new pool for wakanda
        //pool lasts for 200blocks
        newPool = gFactory.deployPool(
            IBEP20(wakandaAddress),
            IBEP20(wakandaAddress),
            wkdPerBlock,
            block.number + 1,
            block.number + 202,
            0,
            admin
        );
        gStake = WakandaPoolInitializable(newPool);
    }

    function testDepositsAndWithdrawals() public {
        vm.startPrank(user1);
        mWAKANDA.get();
        mWAKANDA.approve(newPool, depositValue);
        gStake.deposit(depositValue);
        vm.stopPrank();

        vm.startPrank(user2);
        mWAKANDA.get();
        mWAKANDA.approve(newPool, depositValue);
        gStake.deposit(depositValue);
        vm.stopPrank();

        vm.startPrank(user3);
        mWAKANDA.get();
        mWAKANDA.approve(newPool, 1000000000e18);
        gStake.deposit(depositValue);
        vm.stopPrank();

        //get some rewards into the contract
        mWAKANDA.send(newPool);

        vm.roll(block.number + 2000);

        uint256 balanceBefore = mWAKANDA.balanceOf(newPool);

        // gStake.pendingReward(user1);
        //withdraw rewards only
        vm.prank(user1);
        gStake.deposit(0);

        vm.prank(user2);
        gStake.deposit(0);

        vm.prank(user3);
        gStake.deposit(0);

        //make sure rewards are calculated fine
        //assuming everyone withdraws
        uint256 totalRewardsOut = wkdPerBlock * 201;
        console.log(totalRewardsOut);

        uint256 balanceAfter = mWAKANDA.balanceOf(newPool);
        console.log(balanceBefore);
        console.log(totalRewardsOut);
        assertEq(balanceAfter, balanceBefore - totalRewardsOut);
        gStake.availableRewards();
        vm.prank(user3);
        gStake.deposit(100e9);
        gStake.availableRewards();
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
