import { ethers } from "hardhat";

async function main() {
  const ChainBattles = await ethers.getContractFactory("ChainBattles");
  const battle = await ChainBattles.deploy();
  await battle.deployed();

  console.log(`deployed to ${battle.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
