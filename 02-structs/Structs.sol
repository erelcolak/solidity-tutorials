// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract StructExamples {
    // struct definition
    /*
        struct [StructName] {
            [type] [name];
        }
    */
    struct User {
        uint id;
        string username;
        address userAddress;
        bool isDeleted;
    }
    
    User person1 = User(1, "erelcolak", 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, false);
    User person2 = User({
        id: 2,
        isDeleted: false,
        userAddress: 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,
        username: "erelcolak2"
    });
    // usage
    // person1.username;
    // person2.isDeleted;
    // person1["username"];

    mapping (address => User) userList;

    function createUser(uint _id, string memory _username, address _userAddress, bool _isDeleted) public {
        User memory tempuser = User({
            id: _id,
            username: _username,
            userAddress: _userAddress,
            isDeleted: _isDeleted
        });
        userList[_userAddress] = tempuser;
        // tempuser.id = _id;
        // tempuser.isDeleted = _isDeleted;
        // tempuser.userAddress = _userAddress;
        // tempuser.username = _username;
    }
    function getUser(address _userAddress) public view returns(User memory) {
        return userList[_userAddress];
    }
    function getUsername(address _userAddress) public view returns(string memory) {
        return userList[_userAddress].username;
    }

}