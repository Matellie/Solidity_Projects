// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract USLS is ERC20, Ownable {
    constructor() ERC20("Useless_Token", "USLS") Ownable() {}

    function mint(address account, uint256 amount) onlyOwner external {
        _mint(account, amount);
    }
}