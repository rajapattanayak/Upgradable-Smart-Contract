const Main = artifacts.require("Main");
const Delegate = artifacts.require("Delegate");

contract("Main", accounts => {
  beforeEach(async () => {
    this.mainInstane = await Main.new();
    this.delegateInstane = await Delegate.new();
    await this.mainInstane.changeDelegate(this.delegateInstane.address);
  });

  describe('initialization', async () => {
    it("should set delegate contract address in main contract", async () => {
      let delegateContractAddr = await this.mainInstane.delegateContract();
      assert.equal(
        delegateContractAddr,
        this.delegateInstane.address,
        "delegate address shoule be set"
      );
    });
  });

  describe("delegate call", async () => {
    it("should change total value (state) in main contract", async () => {
      await this.mainInstane.delegateAdd(2, 3);
      let mainTotal = await this.mainInstane.total();
      assert.equal(mainTotal.toNumber(), 5, "main total should change");
    });

    it("should not change total value (state) in delegate contract", async () => {
      await this.mainInstane.delegateAdd(2, 3);
      let delegateTotal = await this.delegateInstane.total();
      assert.equal(delegateTotal.toNumber(), 0, "delegate total should not change");
    });
  });

  describe("normal call", async () => {
    it("should change total value (state) in delegate contract", async () => {
      await this.mainInstane.callAdd(2, 3);
      let delegateTotal = await this.delegateInstane.total();
      assert.equal(delegateTotal.toNumber(), 5, "delegate total should change");
    });

    it("should not change total value (state) in main contract", async () => {
      await this.mainInstane.callAdd(2, 3);
      let mainTotal = await this.mainInstane.total();
      assert.equal(mainTotal.toNumber(), 0, "main total should not change");
    });    
  });

});
