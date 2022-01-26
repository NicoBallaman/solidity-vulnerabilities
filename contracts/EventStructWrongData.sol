// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract EventStructWrongData {

}

//**Cause:
//Events in Solidity are used to log whenever some sort of transaction or interaction with a contract takes place. When a struct
//is used within an event, incorrect data is logged. Instead of logging the data passed into the event, the event logs the address
//of the struct.

//**Attributes:
//Events in Solidity allow programmers to access a special data structure within Solidity called the Log. This structure stores data
//such as contracts' memory addresses and parameters passed into it through events. If a struct is passed into an event, instead of
//any of the data within the struct logged into the Log, only the memory address of the struct is logged.

//**Consequences:
//If a struct is passed into an event, the wrong data gets stored in the Log for the event. This could cause issues with transactions
//with that contract in the future.
