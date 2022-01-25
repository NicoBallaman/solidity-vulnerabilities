// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

//*Cause:
//When elements in an array were changed to values that were <32 bits long, the compiler did not properly clear the
//higher order bits. Thus, on accessing the element, it appeared to have a different value than it was assigned.

//*Attributes:
//This bug would cause data corruption when array data was changed. This would lead to undesired behavior all around.

//*Consequences:
//An attacker could use this exploit to cherry pick input data to gain access to undesired code paths through an overflow.
