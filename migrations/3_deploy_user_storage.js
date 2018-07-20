var UserStorage = artifacts.require("UserStorage");

module.exports = function(deployer) {
  deployer.deploy(UserStorage);
};
