// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Visibility {
    // public - her şekilde erişilebilir
    // private - sadece tanımlandığı contract içerisinde erişilebilir
    // internal - sadece tanımlandığı contract ve de bu contract'i miras alan child contract'ler tarafınca erişilebilir
    // external - contract dışından erişilebilir

    uint public numberPublic = 10;
    uint private numberPrivate = 15;
    uint internal numberInternal = 20;

    function getNumber() public view returns (uint) {
        return numberPublic;
    }

    function getNumberPrivate() private pure returns (uint) {
        return 5;
    }

    function getNumberInternal() internal pure returns (uint) {
        return 10;
    }

    function getNumberExternal() external pure returns (uint) {
        return 15;
    }

    function main() public view {
        getNumber();
        getNumberPrivate();
        getNumberInternal();
    }
}

contract ChildVisibility is Visibility {
    function anotherMain() public view {
        getNumber();
        getNumberInternal();
    }
}

contract AnotherContract {
    Visibility contractVisibility;

    function main() public view {
        contractVisibility.getNumber();
        contractVisibility.getNumberExternal();
    }
}
