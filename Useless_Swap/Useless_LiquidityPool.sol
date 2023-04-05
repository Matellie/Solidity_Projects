// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import 'USLS.sol';

contract Useless_LiquidityPool {

    USLS public USLS_token;

    uint256 public nbLP;
    uint256 public nbSwap;

    constructor() {
        USLS_token = new USLS();
        nbLP = 0;
        nbSwap = 0;
    }

    function addLiquidity() external payable {
        
    }

    function removeLiquidity() external {
        
    }

    function swap_ETHtoUSLS() external payable {
        
    }

    function swap_USLStoETH() external {
        
    }

}