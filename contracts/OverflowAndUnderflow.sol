// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract OverflowAndUnderflow {

    uint32 sellerBalance = 0;

    function add (uint32 value) external {
        //possible overflow
        sellerBalance = sellerBalance + value;
    }
    function safe_add (uint32 value) external {
        require(sellerBalance + value >= sellerBalance);
        sellerBalance = sellerBalance + value;
    }

}

//**Cause:
//The Ethereum Virtual Machine (EVM) has integer data types that are designated with bit level specification; such as
//“uint8” for an 8-bit unsigned integer, or simply “uint,” which is an alias for “uint256,” a 256-bit unsigned integer.
//The bit level specification of integers causes value storage limitations. When performing addition, subtraction, or
//storing user input with integer variables that contain value limitations, overflow/underflow can occur.

//**Attributes:
//Since the current mathematical operators do not utilize the correct overflow/underflow safeguards, mathematical operation
//on integer data types can lead to overflow/underflow. Addition, subtraction, or user input that involves variables with
//value limitations, yet do not utilize value checking will allow overflow/underflow to occur. The contract presented has
//a safe_add() function which utilizes the proper value checking on the result to ensure overflow has not occurred. This was
//done with the require() function, which shall throw an exception if the expression passed results in a Boolean value of false.

//**Consequences:
//Vulnerabilities such as overflow/underflow allows for exploitation to occur when unsafe mathematical operators are utilized
//on the various, bit level specified, integer data types present in Solidity. In order to mitigate these vulnerabilities the
//SafeMath library is recommended, as well the require() function, which allows value checking to occur.
