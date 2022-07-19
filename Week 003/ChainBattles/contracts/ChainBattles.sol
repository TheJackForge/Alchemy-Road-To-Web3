// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract Address: 0x8De17cC52409889004d10b5d3720aA1ceEb64529

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage  {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Stats {
        uint256 level;
        uint256 speed;
        uint256 strength;
        uint256 life;
    }

    mapping(uint256 => Stats) public tokenIdToStats;

    constructor() ERC721 ("Chain Battles", "CBTLS"){
    }

    function generateCharacter(uint256 tokenId) public returns(string memory){

    bytes memory svg = abi.encodePacked(
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
        '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
        '<rect width="100%" height="100%" fill="black" />',
        '<text x="50%" y="30%" class="base" dominant-baseline="middle" text-anchor="middle">',"Chain Battler",'</text>',
        '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",getLevel(tokenId),'</text>',
        '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
        '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",getStrength(tokenId),'</text>',
        '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Life: ",getLife(tokenId),'</text>',
        '</svg>'
    );
    return string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
        )    
    );
    }

    function getLevel(uint256 tokenId) public view returns (string memory) {
        Stats memory _stats = tokenIdToStats[tokenId];
        return _stats.level.toString();
    }

    function getSpeed(uint256 tokenId) public view returns(string memory) {
        Stats memory _stats = tokenIdToStats[tokenId];
        return _stats.speed.toString();
    }

    function getStrength(uint256 tokenId) public view returns(string memory) {
        Stats memory _stats = tokenIdToStats[tokenId];
        return _stats.strength.toString();
    }

    function getLife(uint256 tokenId) public view returns(string memory) {
        Stats memory _stats = tokenIdToStats[tokenId];
        return _stats.life.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
    }

    function mint() public {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    Stats storage _stats = tokenIdToStats[newItemId];
    _stats.level = 0;
    _stats.speed = 420;
    _stats.strength = 69;
    _stats.life = 181;
    _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
    require(_exists(tokenId));
    require(ownerOf(tokenId) == msg.sender, "You must own this NFT to train it!");

    Stats storage _stats = tokenIdToStats[tokenId];

    uint256 currentLevel = _stats.level;
    _stats.level = currentLevel + 1;
    
    uint256 currentSpeed = _stats.speed;
    _stats.speed = currentSpeed + 1;

    uint256 currentStrength = _stats.strength;
    _stats.strength = currentStrength + 1;

    uint256 currentLife = _stats.life;
    _stats.life = currentLife + 1;

    _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}