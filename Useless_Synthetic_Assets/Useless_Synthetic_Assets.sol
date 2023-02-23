// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import 'uUSD.sol';

contract Useless_Stacking is Ownable {

    uUSD public uUSD_token;

    uint8 public collateralFactor;      // value(ETH)/value(uUSD) > 1
    uint8 public liquidationPenalty;    // 0 <= liqPen <= 100 (in percent %)
    uint16 public nbMinters;
    mapping(address => uint) public balances;

    constructor() {
        uUSD_token = new uUSD();
        nbMinters = 0;
    }

    function setCollateralFactor(uint8 _newColFact) onlyOwner external {
        require(_newColFact > 1, "The collateral factor can't <=1 for security reasons !")
        collateralFactor = _newColFact;
    }

    function setLiquidationPenalty(uint8 _newLiqPen) onlyOwner external {
        require(_newLiqPen <= 100, "The liquidation penalty can't be more than 100% !")
        liquidationPenalty = _newLiqPen;
    }

    // Fetch price of ETH from an Oracle
    function getPriceETHUSD() internal {

    }

    // Mint a cretain amount of uUSD matching the target collateral factor
    function mint() external payable {

    }

    // Burn a certain amount of uUSD 
    function burn() external {

    }

    function liquidate(address account) external {
        // Checks if the address can be liquidated

        // Proceeds to liquidate it
    }

    function isSolvable(address account) returns(bool) public {

    }
}