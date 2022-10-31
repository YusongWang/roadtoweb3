const { ethers } = require("hardhat");

async function main() {
  const Casino = await ethers.getContractFactory("Casino");
  const cso = await Casino.deploy();
  await cso.deployed();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
