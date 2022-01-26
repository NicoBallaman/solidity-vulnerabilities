// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract FalseRandomness {

}

//*Cause:
//The Ethereum blockchain protocol requires participants (miners) to verify blocks before they are added to the chain. When verifying
//a block, miners have access to all of the data within said block. Miners also can influence certain attributes of a block, such as the
//timestamp of when a block is mined.

//*Attributes:
//Ethereum and Solidity contracts have no true source of entropy. Some ways that have been used to generate randomness are based on future
//blocks such as timestamps, block numbers, hashes or gas limit. These are not truly random because miners have influence on them.

//*Consequences:
//Contracts which rely on randomness are vulnerable to miner manipulation or influence. For example, consider a lottery contract in which
//users purchase a ticket and one lucky user wins the jackpot. This requires randomness to choose the winner. If a miner wants to increase
//their chances, they could see what the contract uses as a source of entropy and try to manipulate it for their benefit.
