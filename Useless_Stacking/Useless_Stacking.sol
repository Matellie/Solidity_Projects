// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import 'USLS.sol';

contract Useless_Stacking {

    USLS public USLS_token;

    mapping(address => uint) public balances;
    uint16 public nbStackers;

    mapping(address => uint) public timestamps;

    constructor() {
        USLS_token = new USLS();
        nbStackers = 0;
    }

    function stake() external payable {
        require(msg.value > 0, "Invalid staking amount !");

        if(balances[msg.sender] == 0) {
            ++nbStackers;
            balances[msg.sender] += msg.value;
            timestamps[msg.sender] = block.timestamp;
        } else {
            claimRewards();
            balances[msg.sender] += msg.value;
        }
    }

    function unStake(uint _nbETH) external {
        require(0 < _nbETH && _nbETH <= balances[msg.sender], "Invalid amount to un-stake !");

        (bool sent,) = msg.sender.call{value: _nbETH}("");
        require(sent, "An error has occured with the withdrawal !");

        claimRewards();

        balances[msg.sender] -= _nbETH;

        if(balances[msg.sender] == 0) {
            --nbStackers;
            timestamps[msg.sender] = 0;
        }
    }

    function claimRewards() public {
        require(timestamps[msg.sender] > 0, "You do not have any rewards to claim !");

        uint reward = (block.timestamp - timestamps[msg.sender]) * balances[msg.sender];

        USLS_token.mint(msg.sender, reward);
        timestamps[msg.sender] = block.timestamp;
    }

}