// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

contract Variables {
    // [type] [name] = [value];
    // bool
    // default value: false
    bool isAvailable = true;
    bool isWorking = false;
    // string
    // default value: ""
    string username = "erelcolak";
    // integer
    // default value: 0
    int numberInt = 15;
    int numberNegativeInt = -15;
    int8 numberInt8 = 127;
    // unsigned integers - uint
    // default value: 0
    uint numberUint = 0;
    uint128 numberUint128 = 1000;
    // address
    // default value: 0x0000000000000000000000000000000000000000 || address(0)
    address userAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // array
    uint[] newArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[5] newArrayFixedSize = [1, 2, 3, 4, 5];
    // mapping
    mapping(address => uint) userAddressList;

    // state variables
    // local variables
    // global variables
    function getNumber() public pure returns (uint) {
        uint numberTemp = 5;
        return numberTemp;
    }

    function getUserAddress() public view returns (address) {
        address tempAddress = msg.sender;
        return tempAddress;
    }
}
