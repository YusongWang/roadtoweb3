// scripts/withdraw.js

const hre = require("hardhat");
const abi = require("../artifacts/contracts/Bull&Bear.sol/BullBear.json");


async function main() {
  // Get the contract that has been deployed to Goerli.
  const contractAddress="0x7F27698B883008440f448791CCe856540aFa7A3B";
  const contractABI = abi.abi;


  // Get the node connection and wallet connection.
  const provider = new hre.ethers.providers.AlchemyProvider("goerli", process.env.GOERLI_API_KEY);

  // Ensure that signer is the SAME address as the original contract deployer,
  // or else this script will fail with an error.
  const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

  // Instantiate connected contract.
  const bull = new hre.ethers.Contract(contractAddress, contractABI, signer);

  await bull.safeMint(signer.address);  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });