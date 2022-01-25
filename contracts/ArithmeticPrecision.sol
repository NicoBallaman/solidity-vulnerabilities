// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract ArithmeticPrecision {

    uint constant public tokensPerEth = 10;
    uint constant public weiPerEth = 1e18;
    mapping(address => uint) public balances;

    function buyTokens() public payable {
        //convert wei to eth, then multiply by token rate
        uint tokens = msg.value/weiPerEth*tokensPerEth;
        balances[msg.sender] += tokens;
    }

    function sellTokens(uint tokens) public {
        require(balances[msg.sender] >= tokens);
        uint eth = tokens/tokensPerEth;
        balances[msg.sender] -= tokens;
        payable(msg.sender).transfer(eth*weiPerEth);
    }

}

//**Cause:
//As of Solidity v0.4.24, neither floating point or decimal types are supported. Since floating point representations cannot
//be directly represented with their own data type, they must be made with integer types in Solidity.

//**Attributes:
//In the development or use of floating-point representations these things were not considered and led to incorrect results:
//(1) integer division, in Solidity, will be rounded down;
//(2) order of operations;
//(3) high precision to low precision conversion should only be done following mathematical operation.
//The contract will cause incorrect results to occur despite the mathematical calculations being correct; this is due to a
//lack of a proper floating-point data type.

//**Consequences:
//If the process of using integer types for floating point representations is done improperly, it can produce errors and
//vulnerabilities. These errors can be especially pernicious when the faulty result relates to financial transactions.
