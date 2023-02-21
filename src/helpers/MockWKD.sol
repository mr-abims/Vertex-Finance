pragma solidity ^0.6.0;

import "@openzeppelin/token/ERC20/ERC20.sol";

contract MOCKWAKANDA is ERC20("WAKANDA", "WKD") {
    constructor() public {
        //  _mint(msg.sender, 1000000e9);
    }

    function get() public {
        _mint(msg.sender, 100_000e9);
    }

    //mint a lot of tokens to target
    function send(address _target) public {
        _mint(_target, 100_000_000e9);
    }

    function decimals() public view override returns (uint8) {
        return 9;
    }
}
