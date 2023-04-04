// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
    // We get the contract to deploy
    const NFT = await hre.ethers.getContractFactory("NFT");
    const nft = await NFT.deploy();

    await nft.deployed();

    if(hre.network.config.chainId ===97){
        nft.deployTransaction.wait(6);
        await verifyContract(nft.address)
    }

    console.log("NFT deployed to:", nft.address);

    // We also save the contract's artifacts and address in the frontend directory

}
async function verifyContract(address,args=[]){
    await hre.run("verify:verify", {
        address: address,
        constructorArguments: args,
    });
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
