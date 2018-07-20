pragma solidity ^0.4.23;

// This Contract can not be changed once deployed. 
// It will call delegate functions in Delegate contract to change its state. 

contract Main {
    address public delegateContract;
    address[] public previousDelegates;

    uint256 public total;

    event DelegateChanged(
        address oldAddress,
        address newAddress
    );

    constructor() public {}

    function changeDelegate(address _newDelegate) public returns (bool) {
        if (_newDelegate != delegateContract) {
            previousDelegates.push(_newDelegate);
            address oldDelegate = delegateContract;
            delegateContract = _newDelegate;
            
            emit DelegateChanged(oldDelegate, _newDelegate);

            return true;
        }
        return false;
    }

    // Change state of Main contract
    function delegateAdd(uint256 number1, uint256 number2) public {
        require(delegateContract.delegatecall(bytes4(keccak256("add(uint256,uint256)")), number1, number2));
    }

    // Change state of Delegate Contract
    function callAdd(uint256 number1, uint256 number2) public {
        require(delegateContract.call(bytes4(keccak256("add(uint256,uint256)")), number1, number2));
    }
}