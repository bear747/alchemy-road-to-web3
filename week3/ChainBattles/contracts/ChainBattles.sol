// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import useful oz contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

//Contract deployed to:  0x019c58b1678E566d866c506827ba4813bF8B451b


contract ChainBattles is ERC721URIStorage  { // ChainBattles contract inherits from the oz ERC721URIStorage contract
    // pull in other oz contracts here
    using Strings for uint256; 
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // create structure for the game player's data [CHALLENGE EDIT]
    struct GamerData {
      uint256 level;
      uint256 speed;
      uint256 strength;
      uint256 life;
    }

    // GamerData maps to uint256s [CHALLENGE EDIT]
    mapping(uint256 => GamerData) public tokenIdToGamerData;

    // ERC721 is an open zepplin contract - see docs? https://docs.openzeppelin.com/contracts/4.x/erc721#:~:text=ERC721%20is%20a%20standard%20for,across%20a%20number%20of%20contracts.
    constructor() ERC721 ("Chain Battles", "CBTLS"){
    }

    // create a character function.  Pass in a tokenId, creates an image (svg) and returns the bytes for that image.
    function generateCharacter(uint256 tokenId) public returns(string memory){

        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",getLevel(tokenId),'</text>',
            '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
            '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",getStrength(tokenId),'</text>',
            '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">', "Life: ",getLife(tokenId),'</text>',
            '</svg>'
        );
        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            )    
        );
    }  

    // create a "random" number (not really random because blockchains are deterministic, but will do for now)
    function generateRandomNumber(uint256 number) public view returns(uint256) {
      return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % number;
    }

    // these functions set the level, strength, life and speed
    function getLevel(uint256 tokenId) public view returns (string memory) {
      GamerData memory data = tokenIdToGamerData[tokenId];
      return data.level.toString();
    }

    function getStrength(uint256 tokenId) public view returns (string memory) {
      GamerData memory data = tokenIdToGamerData[tokenId];
      return data.strength.toString();
    }

    function getLife(uint256 tokenId) public view returns (string memory) {
      GamerData memory data = tokenIdToGamerData[tokenId];
      return data.life.toString();
    }

    function getSpeed(uint256 tokenId) public view returns (string memory) {
      GamerData memory data = tokenIdToGamerData[tokenId];
      return data.speed.toString();
    }

    // get the token URI (Uniform Resource Identifier) (seems like we're adding metadata here)
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

    // mint the tokens
    function mint() public {
        _tokenIds.increment(); // increment tokenIds (+1 presumably)
        uint256 newItemId = _tokenIds.current(); // new item ID (based on current from above)
        _safeMint(msg.sender, newItemId); // internal function to safely mint a new token (takes an address + tokenId)
        GamerData memory GamerData = GamerData(0, generateRandomNumber(2), generateRandomNumber(3), generateRandomNumber(4)); // add level (always zero), speed, strength, life values to GamerData structure
        tokenIdToGamerData[newItemId] = GamerData; // adds new GamerData struct to the master tokenIdToGamerData struct
        _setTokenURI(newItemId, getTokenURI(newItemId)); // sets the token URI
    }

    // train the character (i.e. level up)
    function train(uint256 tokenId) public {
      require(_exists(tokenId));  // the token must exist...
      require(ownerOf(tokenId) == msg.sender, "You must own this NFT to train it!"); // ...and you must own it to train it!

      GamerData memory currentGamerData = tokenIdToGamerData[tokenId]; // sets up currentGamerData struct
      uint256 currentLevel = currentGamerData.level; // determine the current level
      currentGamerData.level = currentLevel + 1; // +1 to current level
      tokenIdToGamerData[tokenId] = currentGamerData; // set tokenIdToGamerData for tokenId based on the current player's data
      _setTokenURI(tokenId, getTokenURI(tokenId)); // set the token URI base on tokenId
    }



}