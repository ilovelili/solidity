// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Crud {
    struct User {
        uint256 id;
        string name;
    }

    User[] private users;
    uint256 private nextId = 1;

    function create(string calldata _name) external {
        users.push(User(nextId, _name));
        nextId++;
    }

    function read(uint256 _id) external view returns (User memory user) {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].id == _id) {
                uint256 id = users[i].id;
                string memory name = users[i].name;
                return User(id, name);
            }
        }
    }

    function update(uint256 id, string memory name) external {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].id == id) {
                users[i].name = name;
            }
        }
    }

    function destroy(uint256 id) external {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].id == id) {
                delete users[i];
            }
        }
    }
}
