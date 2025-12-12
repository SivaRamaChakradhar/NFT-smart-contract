// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NftCollection is ERC721, Ownable, Pausable {
    uint256 private _maxSupply;
    uint256 private _totalSupply;
    string private _baseTokenURI;

    mapping(uint256 => string) private _tokenURIs;

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_,
        string memory baseURI_
    ) ERC721(name_, symbol_) {
        require(maxSupply_ > 0, "Max supply must be > 0");
        _maxSupply = maxSupply_;
        _baseTokenURI = baseURI_;
    }

    /** VIEW FUNCTIONS **/

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function maxSupply() external view returns (uint256) {
        return _maxSupply;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: Token does not exist");

        string memory tokenSpecificURI = _tokenURIs[tokenId];
        if (bytes(tokenSpecificURI).length > 0) {
            return tokenSpecificURI;
        }

        return string(abi.encodePacked(_baseTokenURI, Strings.toString(tokenId)));
    }

    /** ADMIN FUNCTIONS **/

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function setBaseURI(string memory newBaseURI) external onlyOwner {
        _baseTokenURI = newBaseURI;
    }

    /** MINTING **/

    function safeMint(address to, uint256 tokenId, string memory tokenURI_) external onlyOwner whenNotPaused {
        require(to != address(0), "Cannot mint to zero address");
        require(!_exists(tokenId), "Token already minted");
        require(_totalSupply + 1 <= _maxSupply, "Max supply reached");

        _safeMint(to, tokenId);
        if (bytes(tokenURI_).length > 0) {
            _tokenURIs[tokenId] = tokenURI_;
        }
        _totalSupply += 1;
    }

    /** OVERRIDES **/

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override
        whenNotPaused
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}
