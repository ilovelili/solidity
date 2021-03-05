// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;

contract StorageVSMemory {
    string[] public items;

    function testStorage() public {
        // clear array
        delete items;
        items.push("apple");
        items.push("orange");
        // By adding storage , newItems now POINTS to the items array.
        // In other words, any changes you make to newItems , will directly affect the items array
        string[] storage newItems = items;
        newItems[1] = "banana";
        // items[1] will now be banana
        // items[0] will remain the same as apple
    }

    function testMemory() public {
        delete items;
        items.push("apple");
        items.push("orange");
        // The memory option functions as a copy as opposed to a pointer.
        // Thus, using the memory key and making mutations on the newly created variable WILL NOT affect the original state variable
        string[] memory newItems = items;
        newItems[1] = "banana";
        // items[1] will remain the same as banana
    }
}
