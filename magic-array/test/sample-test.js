const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TestMagicArray", function () {
  it("Test", async function () {
    const MagicArray = await ethers.getContractFactory("MagicArray");
    const contract = await MagicArray.deploy();
    await contract.deployed();
	
    await new Promise((r) => setTimeout(r, 500));

    const t1 = await contract.pickIdOne();

    // wait until the transaction is mined
    await t1.wait();
  });
});
