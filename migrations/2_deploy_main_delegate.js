const Main     = artifacts.require("Main");
const Delegate = artifacts.require("Delegate");

module.exports = (deployer) => {
  deployer.deploy(Main).then(() => {
    return deployer.deploy(Delegate);
  });
};