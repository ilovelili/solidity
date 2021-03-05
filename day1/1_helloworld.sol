// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;

contract SimpleContract {
    string private helloworld = "hello world";

    // pure: no interaction with variables outside the function
    function greet1() public pure returns (string memory) {
        return "hello world";
    }

    // view: read the variables outside the function
    function greet2() public view returns (string memory) {
        return helloworld;
    }
}
