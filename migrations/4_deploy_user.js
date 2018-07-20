var UserContract = artifacts.require("UserContract");
var UserStorage = artifacts.require("UserStorage");

module.exports = function(deployer) {
  deployer.deploy(UserContract, UserStorage.address).then(() => {
    UserStorage.deployed().then((storageInstance) => {
      return storageInstance.allowAccess(UserContract.address);
    });
  });
};
