// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;

contract CalldataVSMemory {
    function memoryTest(string memory test)
        public
        pure
        returns (string memory)
    {
        test = "example"; // You can modify memory
        return test; // You can return memory
    }

    // calldata is cheaper (costs less gas) than memory
    function calldataTest(
        string calldata test /** calldata only available for external functions */
    ) external pure returns (string memory) {
        // TypeError: Type literal_string "abc" is not implicitly convertible to expected type string calldata. test = "abc"
        test = "abc"; // cannot modify or return calldata
        return test; // cannot return calldata
    }
}
