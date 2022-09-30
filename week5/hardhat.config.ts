import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config()

const GOERLI_URL = process.env.GOERLI_URL;
const PRIVATE_KEY:any = process.env.PRIVATE_KEY;
const SCAN_PRIVATE:any = process.env.GOERLI_API_KEY;

const settings = {
  optimizer: {
    enabled: true,
    runs: 200,
  },
  outputSelection: {
    "*": {
      "*": ["storageLayout"],
    },
  },
};

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
    { version: "0.5.16", settings },
    { version: "0.6.6", settings },
    { version: "0.6.12", settings },
    { version: "0.7.5", settings },
    { version: "0.8.2", settings },
    { version: "0.8.4", settings },
    { version: "0.8.10", settings }
  ]
  },
  networks: {
    goerli: {
      url: GOERLI_URL,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: {
      goerli: SCAN_PRIVATE,
    }
  }  
};

export default config;
