// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract TimestampManipulation {
    uint public pastBlockTime;
    constructor() payable {}

    fallback() external payable {
        require(msg.value == 10 ether);
        //only 1 transaction per block
        require(block.timestamp != pastBlockTime);
        pastBlockTime = block.timestamp;
        if(block.timestamp % 15 == 0){
            payable(msg.sender).transfer(address(this).balance);
        }
    }

}

//**Cause:
//A whole host of applications utilize time constraints to ascertain which actions are permitted or mandatory in a current
//state. Typically, time constraints are executed by using block timestamps. Block Timestamps have been used for a wide variety
//of applications.

//**Attributes:
//The miner who creates a new block-instantiation of a contract on the blockchain can determine the timestamp of the block within
//a certain degree. Since miners can adjust timestamps slightly, there exists the potential for nefarious use; this potential is
//contingent upon the way in which the block timestamp is utilized. If the block timestamp represents a determining factor in a
//financial transaction and the miner holds a stake in the contract, he then could have motive to manipulate the timestamp to gain
//an advantage. The contract contains this fault. If this contract collects enough ether then the miner would have incentive, and
//ample opportunity due to the use of the block timestamp, to gain an unfair advantage and acquire the funds.

//**Consequences:
//Since block timestamp manipulation can be used by miners, block timestamps have the potential to lead to contract vulnerabilities.
