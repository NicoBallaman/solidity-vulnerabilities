// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract TokenAPIViolation {

    function transferFrom(address _spender, uint _value) external returns(bool success) {
        require(_value < 20 wei);
        //...
    }

}

//**Cause:
//Violation of the ERC-20 standard token interface by implementing functions with incorrect return types, parameters,
//or names. Or by failing to implement interface functions entirely.

//**Attributes:
//ERC-20 is de-facto standard API for implementing tokens transferable units of value managed by a contract. Exchanges
//and other third-party services may struggle to integrate a token that does not conform to it.

//**Consequences:
//Contracts that wish to provide users with a currency will find that their currency does not meet the standards for trade
//with other contracts. The example of Token API Violation. ERC-20 functions such as approve, transfer, and
//trasferFrom should not have exceptions (revert, throw, require, assert) thrown inside them. Library functions, especially
//third party library functions, may throw exceptions.
