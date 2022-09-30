import { ethers } from "hardhat";

async function main() {
  const BullBear = await ethers.getContractFactory("BullBear");
  const bull = await BullBear.deploy(50000,"0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e","0x2ca8e0c643bde4c2e08ab1fa0da3401adad7734d");
  await bull.deployed();

  console.log("BullBear deployed to:", bull.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
