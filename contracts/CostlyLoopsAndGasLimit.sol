// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract CostlyLoopsAndGasLimit {
    address[] availableAddresses;

    function isAddressAvailable(address adr) view external returns (bool){
        for(uint256 i = 0; i< availableAddresses.length; i++){
            if(availableAddresses[i] == adr){
                return true;
            }
        }
        return false;
    }

}

//**Cause:
//A loop containing a resource-costly function. This vulnerability could be the result of faulty development or malicious
//intent by a third party. In the event that a malicious party obtains the ability to manipulate a mapping or array, the
//vulnerability called “looping over externally manipulated mappings or arrays” will cause a Costly Loop to occur.

//**Attributes:
//Ethereum is a very resource constrained environment. Gas is the computational cost of performing operation, and contracts
//can only use however much gas the user sends with a transaction.

//**Consequences:
//If a costly loop drains the contract of gas then the contract will fail. If array.length is large enough, the contract containing
//this loop will exceed the block gas limit and transactions utilizing this contract will fail.
