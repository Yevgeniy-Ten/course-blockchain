const {ethers} = require("hardhat");
const {expect} = require("chai");
describe('NFT', function () {
    let nft = null;
    beforeEach(async function () {
        const NFT = await ethers.getContractFactory("NFT");
        nft = await NFT.deploy();
        await nft.deployed();
    });
    it('Should deploy NFT contract', async function () {
        expect(await nft.name()).to.equal("CAT_NFT");
    });

    it('Should mint NFT', async function () {
        await nft.mint("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", 1);
        expect(Number(await nft.totalSupply())).to.equal(1);
    });

    it('error when supply has end', async function () {
        const maxSupply = 10;
        for (let i = 0; i < maxSupply; i++) {
            nft.send
            await nft.safeMint("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",{
                value: ethers.utils.parseEther("0.00001")
            });
        }
        const result = nft.safeMint("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",{
            value: ethers.utils.parseEther("0.00001")
        })
        await expect(result).to.be.revertedWith("You reached max supply");
    });
});
