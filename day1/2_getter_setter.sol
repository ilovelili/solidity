// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;

contract GetterSetter {
    string private data;

    function set(string memory _data) public {
        data = _data;
    }

    function get() public view returns (string memory) {
        return data;
    }
}
