// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract UncheckedExternalCall {

    bool public payedOut = false;
    address payable public winner;
    address payable public owner;
    uint public ammount;

    constructor (){
        owner = payable(msg.sender);
    }

    function sentToWinner() external onlyOwner {
        require(!payedOut);
        // Unchecked external call
        winner.send(ammount);
        payedOut = true;
    }

    function withdrawLeftOver() external  onlyOwner{
        require(payedOut);
        owner.send(address(this).balance);
    }

    modifier onlyOwner() {
        if (msg.sender == owner) _;
    }
}


//**Cause:
//Using the call opcode without checking the return value.

//**Attributes:
//The CALL opcode is often used to transfer ether to an address. If the CALL fails it will not revert the contract
//but will return false. both the address.call() and address.send() methods use the CALL opcode. The example presented
//is of a contract which does not check the return value of address.send(). This send represents a change in the contract
//state. paidout is set to true after the send is made, assuming that the winnings have been paid out. This can be abused
//if the addressee causes the send to fail. This sets paidout to true and the balance of the contract remains the same.

//**Consequences:
//If a contract’s state is changed when the call opcode is used, then the state of the contract can be manipulated by
//the addressee of the call.
