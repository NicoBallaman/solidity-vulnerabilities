// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

//Typically, there are 2 ways one can send Ether forcibly to another contract, and it will not use any payable
//function for that. These are – Pre-sent Ether and Self-destruct methods. In most cases, the blockchain developers
//don’t realize that you can accept or even obtain Ether via other means aside from the payable function. Typically,
//it can lead to contracts having a false Ether balance, and it will lead to vulnerability. It’s best to check
//the current Ether stored in the contract when before calling any functions.