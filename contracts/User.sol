pragma solidity ^0.4.23;

contract UserStorage {
    // Actual User address who calls the user contract
    mapping(address => bool) addressSet;

    // ACCESS for UserContract
    mapping(address => bool) accessAllowed;
    
    constructor() public {
        accessAllowed[msg.sender] = true;
    }

    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }

    // User contract address should be passed
    function allowAccess(address _address) platform public {
        accessAllowed[_address] = true;
    }
    function denyAccess(address _address) platform public {
        accessAllowed[_address] = false;
    }

    function getAddress(address _userAddress) public view returns (bool) {
        return addressSet[_userAddress];
    }
    // Check if user contract that calls has the access
    function setAddress(address _userAddress, bool _value) platform public {
        addressSet[_userAddress] = _value;
    }
}

contract UserContract {
    UserStorage userStorage;

    constructor(address _userStorageAddress) public {
        // User storage already created and address being passed 
        // so user contract will load the storage contract from the ref address
        userStorage = UserStorage(_userStorageAddress);
    }

    function isMyUserNameRegistered() public view returns (bool) {
        return userStorage.getAddress(msg.sender);
    }

    function registerMe() public {
        return userStorage.setAddress(msg.sender, true);
    }
}