// This is the license identifier

// SPDX-License-Identifier: MIT

// This is what version of solidity we will be writing this smart contract for.

pragma solidity ^0.8.4;

// These are the libraries we are importing from the OpenZeppelin repository.

import "@openzeppelin/contracts@4.7.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.0/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts@4.7.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol";

// This is where we initialize our contract.
// The "is" keyword is what allows us to inherit certain features from other smart contracts.

contract JForge is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {

    // This is where we initialize the Counters library, which is what will be used to keep track of our NFT IDs.
    using Counters for Counters.Counter;

    // The private signifies that this will only be visible and utilized by this smart contract.
    Counters.Counter private _tokenIdCounter;

    // The constructor is what is creating the instance of our smart contract. We are going to run ERC721() and pass in the parameters of the name and symbol of our smart contract.
    constructor() ERC721("JForge", "JACK") {}

    // This is the mint function. This will create a new entry on the blockchain - in this function we will save an address, uri, and a tokenId.

    // address: Used to store addresses in the smart contract
    // string: A series of characters composing a word.
    // public: Anything marked public will be accessible by anyone at any given time.
    // onlyOwner: This is from the Ownable library. The onlyOwner modifier makes a function revert if not called by the address registered as the owner. For this smart contract, we would like the users to be able to mint their own NFTs, so we will be removing onlyOwner and deleting the import of the Ownable library (which I have commented out above).

    // original function
//     function safeMint(address to, string memory uri) public onlyOwner {
//     uint256 tokenId = _tokenIdCounter.current();
//     _tokenIdCounter.increment();
//     _safeMint(to, tokenId);
//     _setTokenURI(tokenId, uri);
// }

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
