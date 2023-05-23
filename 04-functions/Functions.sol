// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Functions {
    // definition of functions
    /*
        function [functionName]( [type] [parameterName] ) [visibility] [access] [modifier] returns([type]) {
            // ...
        }
    */
    // pure - state değişkenleri kullanmayan fonksiyonlardır
    // view - state değişkenleri sadece okuyan fonksiyonlardır
    uint number = 5;

    function increaseNumber(uint _numberOne) public view returns (uint) {
        return number + _numberOne;
    }

    function sumNumbers(
        uint _numberOne,
        uint _numberTwo
    ) public pure returns (uint) {
        return _numberOne + _numberTwo;
    }

    function getNumber() public view returns (uint) {
        return number;
    }

    function setNumber() public {
        number = number + 5;
    }

    function multiply(
        uint _numberFirst,
        uint _numberSecond
    ) public pure returns (uint, uint, uint) {
        return (_numberFirst * _numberSecond, _numberFirst, _numberSecond);
    }

    function divide(
        uint _numberFirst,
        uint _numberSecond
    ) public pure returns (uint division, uint firstNumber) {
        division = _numberFirst / _numberSecond;
        firstNumber = _numberFirst;
        return (division, firstNumber);
    }
}
