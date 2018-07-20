pragma solidity ^0.4.23;

// This contract is upgradable.

contract Delegate {
    address public delegateContract;
    address[] public previousDelegates;

    uint256 public total;

    event DelegateChanged(
        address oldAddress,
        address newAddress
    );

    constructor() public {}

    function add(uint256 number1, uint256 number2) public {
        total = number1 + number2;
    }
}

