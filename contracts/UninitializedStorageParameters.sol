// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract UninitializedStorageParameters {

    bool public unlocked = false; // no allow to update name
    struct NameRecord {
        bytes32 name;
        address mappedAddress;
    }
    mapping(address => NameRecord) public registredNameRecord; //records names registred
    mapping(bytes32 => address) public resolve; // hases to addresses

    function register(bytes32 _name, address _mappedAddress)external {
        NameRecord newRecord;
        newRecord.name = _name;
        newRecord.mappedAddress = _mappedAddress;
        resolve[_name] = _mappedAddress;
        registredNameRecord[msg.sender] = newRecord;
        require(unlocked);
    }


}

//**Cause:
//Uninitialized complex data types, such as structs, can lead to issues with storage pointers.

//**Attributes:
//Depending on the type of variable, the EVM will use memory or storage space for the variable data. If local storage
//variables are uninitialized, they can unexpectedly point to other local storage variables in the contract.

//**Consequences:
//Uninitialized storage variables can be used intentionally to exploit users. Uninitialized storage variables could
//cause a contract to function differently than the developer had intended. In this example contract, there is a
//vulnerability that effectively unlocks the initially locked contract. The unlocked variable is indirectly affected
//and can be changed due to the fact that newRecord is not initialized. Solidity stores state variables sequentially
//in storage, due to this unlocked will be stored in slot 0. Since Solidity defaults complex data types, such as structs,
//to storage when declaring them as local variables, it becomes a pointer to storage. Due to the fact that newRecord is
//uninitialized it is pointing to slot 0, where unlocked is stored. When setting newRecord.name to _name we are effectively
//changing the storage slot 0 where the variable unlocked is stored. If _name has its last byte be non-zero, then unlock is
//true and the contract is unlocked.
