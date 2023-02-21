pragma solidity ^0.6.0;

import "@openzeppelin/token/ERC20/ERC20.sol";

contract MockREWARD is ERC20("REWARD TOKEN", "RWD") {
    constructor() public {}

    function setAddress(address _genericStake) public {
        _mint(_genericStake, 100000000000e18);
    }
}
