// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "@OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract uUSLS is ERC20, Ownable {
    constructor() ERC20("Useless_USD", "uUSD") Ownable() {}

    function mint(address account, uint256 amount) onlyOwner external {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) onlyOwner external {
        _burn(account, amount);
    }
}