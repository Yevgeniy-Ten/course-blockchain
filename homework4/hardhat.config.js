require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  defaultNetwork: "hardhat",
  networks: {
    bnbt: {
      url: process.env.BNBT_RPC_URL,
      accounts: [process.env.BNBT_PRIVATE_KEY],
      chainId: 97,
    },
  },
  etherscan:{
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};
