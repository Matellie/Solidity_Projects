// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import './uUSD.sol';
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Useless_Stacking is Ownable {
    using SafeCast for int256;
    using SafeMath for uint256;

    uUSD public uUSD_token;

    // Network: Goerli Aggregator: ETH/USD 
    // Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    AggregatorV3Interface internal eth_usd_priceFeed;

    struct UserBalance {
        uint256 nb_ETH;
        uint256 nb_uUSD;
    }

    uint8 public collateralFactor;      // value(ETH)/value(uUSD)=collateralFactor > 100 (in percent %)
    uint8 public liquidationPenalty;    // 0 <= liqPen <= 100 (in percent %)
    uint16 public nbMinters;

    // FOR TESTING //
    uint public ETHprice;
    
    mapping(address => UserBalance) public balances;

    constructor() Ownable() {
        uUSD_token = new uUSD();
        eth_usd_priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);

        collateralFactor = 200;
        liquidationPenalty = ;
        nbMinters = 0;
    }

    function setCollateralFactor(uint8 _newColFact) onlyOwner external {
        require(_newColFact > 1, "The collateral factor can't <=1 for security reasons !");
        collateralFactor = _newColFact;
    }

    function setLiquidationPenalty(uint8 _newLiqPen) onlyOwner external {
        require(0 <= _newLiqPen && _newLiqPen <= 100, "The liquidation penalty must be between 0 and 100% !");
        liquidationPenalty = _newLiqPen;
    }

    // Fetch price of ETH from an Oracle
    function getPriceETHUSD() public returns(uint256) {
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = eth_usd_priceFeed.latestRoundData();

        ETHprice = price.toUint256();

        return ETHprice;
    }

    // Mint a cretain amount of uUSD matching the target collateral factor
    function mint(uint256 _amount_uUSD) external payable {
        // Checks that the minimum collateral factor is reached
        require(msg.value*getPriceETHUSD()/_amount_uUSD > collateralFactor, "The target collateral factor is not valid !");

        // Update user balance
        balances[msg.sender].nb_ETH += msg.value;
        balances[msg.sender].nb_uUSD += _amount_uUSD;

        // Mint the tokens
        uUSD_token.mint(msg.sender, _amount_uUSD);
    }

    // Burn a certain amount of uUSD to get ETH back
    function burn(uint256 _amount_uUSD) external {
        // Burn the tokens
        uUSD_token.burn(msg.sender, _amount_uUSD);
    }

    function withdrawCollateral(uint256 _amount_ETH) public {

    }

    function liquidate(address account) external {
        // Checks if the address can be liquidated

        // Proceeds to liquidate it
    }

    function isSolvable(address account) public returns(bool) {

    }
}