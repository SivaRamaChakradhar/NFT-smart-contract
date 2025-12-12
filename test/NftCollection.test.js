const { expect, use } = require("chai");
const { ethers } = require("hardhat");

describe("NftCollection", function () {
  let nft, owner, addr1, addr2;
  const NAME = "MyNFT";
  const SYMBOL = "MNFT";
  const MAX_SUPPLY = 5;
  const BASE_URI = "https://example.com/metadata/";

  const AddressZero = "0x0000000000000000000000000000000000000000";

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    const NftFactory = await ethers.getContractFactory("NftCollection");
    nft = await NftFactory.deploy(NAME, SYMBOL, MAX_SUPPLY, BASE_URI);
  });

  describe("Deployment", function () {
    it("Should set name, symbol, maxSupply correctly", async function () {
      expect(await nft.name()).to.equal(NAME);
      expect(await nft.symbol()).to.equal(SYMBOL);
      expect(await nft.maxSupply()).to.equal(MAX_SUPPLY);
      expect(await nft.totalSupply()).to.equal(0);
    });
  });

  describe("Minting", function () {
    it("Owner can mint a token", async function () {
      await expect(nft.safeMint(addr1.address, 1, "token1.json"))
        .to.emit(nft, "Transfer")
        .withArgs(AddressZero, addr1.address, 1);

      expect(await nft.totalSupply()).to.equal(1);
      expect(await nft.balanceOf(addr1.address)).to.equal(1);
      expect(await nft.tokenURI(1)).to.equal("token1.json");
    });

    it("Cannot mint to zero address", async function () {
      await expect(
        nft.safeMint(AddressZero, 1, "")
      ).to.be.revertedWith("Cannot mint to zero address");
    });
  });

  describe("Events", function () {
    it("Transfer event is emitted on mint", async function () {
      await expect(nft.safeMint(owner.address, 1, ""))
        .to.emit(nft, "Transfer")
        .withArgs(AddressZero, owner.address, 1);
    });
  });
});
