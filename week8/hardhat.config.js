require("@nomiclabs/hardhat-waffle");
require('dotenv').config()

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  solidity: "0.8.4",

  networks: {
    "optimism": {
       url: process.env.URL,
       accounts: [ process.env.MNEMONIC ]
    }
  }
};
