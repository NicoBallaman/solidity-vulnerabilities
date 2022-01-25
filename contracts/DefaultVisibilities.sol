// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

//In Solidity, the functions have visibility to the public unless you are assigning how anyone can call that function.
//Therefore, the visibility can determine who can call the function – external users, derived contracts, internal users,
//etc. Typically, there are four types of visibility specifiers. Thus, any function which is default to public viewing
//can be called by users externally. In reality, many times, the developers tend to use incorrect specifiers, which will
//severely damage the integrity of the smart contract.
//As the default is public, so always make sure to specify the visibility if you want to change it.