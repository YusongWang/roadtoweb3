// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;

    struct People {
        uint256 level;
        uint256 speed;
        uint256 strength;
        bool life;
    }

    Counters.Counter private _tokenIds;

    mapping(uint256 => People) public tokenIdToPeople;

    constructor() ERC721("Chain Battles", "CBTLS") {}

    function getLevels(uint256 tokenId) public view returns (string memory) {
        People memory people = tokenIdToPeople[tokenId];
        return people.level.toString();
    }

    function getLife(uint256 tokenId) public view returns (string memory) {
        People memory people = tokenIdToPeople[tokenId];
        if (people.life) {
            return "Yes";
        } else {
            return "No";
        }
    }

    function getSpeed(uint256 tokenId) public view returns (string memory) {
        People memory people = tokenIdToPeople[tokenId];
        return people.speed.toString();
    }

    function generateCharacter(uint256 tokenId) public returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getLevels(tokenId),
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Speed: ",
            getSpeed(tokenId),
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Is life: ",
            getLife(tokenId),
            "</text>",
            "</svg>"
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getTokenURI(uint256 tokenId) public returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Battles #',
            tokenId.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
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
        People memory people;
        people.level = 0;
        people.life = true;
        people.speed = random(newItemId);
        people.strength = random(newItemId + 10);

        tokenIdToPeople[newItemId] = people;
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );

        People memory people = tokenIdToPeople[tokenId];
        
        people.level = people.level + 1;
        people.speed = people.speed + 10;
        people.strength = people.speed + 20;

        tokenIdToPeople[tokenId] = people;

        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

    function random(uint number) public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        msg.sender
                    )
                )
            ) % number;
    }
}
