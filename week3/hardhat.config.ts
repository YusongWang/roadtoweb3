import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

require("dotenv").config()

const PRIVATE_KEY:any = process.env.PRIVATE_KEY;
const SCAN_KEY:any = process.env.POLYGONSCAN_API_KEY;


const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url: process.env.TESTNET_RPC,
      accounts: [PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: SCAN_KEY
    }
  }  
};

export default config;
