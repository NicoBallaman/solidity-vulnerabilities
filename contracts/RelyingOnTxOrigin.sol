// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract TxOriginVictim {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function transferTo(address to, uint amount) public {
        require(tx.origin == owner);
        payable(to).transfer(amount);
    }

    fallback() payable external {}
}

contract TxOriginAttacker {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    fallback() payable external {
        TxOriginVictim victim = new TxOriginVictim();
        victim.transferTo(owner, msg.sender.balance);
    }
}

//tx.origin breaks compatibility. Using tx.origin means that your contract cannot be used by another contract,
//because a contract can never be the tx.origin.
//tx.origin is a global variable and will scan the call stack and give you the address of the account that sent
//the transaction. The problem is that if you use this variable for authentication purposes, it can make your
//smart contracts vulnerable. Therefore, there is a heavy chance that your contract will face a phishing attack.
//Basically, the attacker can trick the user into using the tx.origin variable to authenticate the attacker to
//the contract.

//Never use tx.origin to check for authorisation of ownership, instead use msg.sender