# Road To Web3 - Week 3 Tutorial Notes

https://www.youtube.com/watch?v=8FJvY4zXvPE



## Project Setup

Make ChainBattles dir and cd to dir.  Do all the following in terminal

% npm init -y

Install HardHat

% yarn add hardhat

Add hardhat and set up basic JS project

% npx hardhat

Add some useful packages

% yarn add @openzeppelin/contracts @nomiclabs/hardhat-etherscan dotenv

I also had to install some waffle packages to get this to work

% npm install -D @nomiclabs/hardhat-waffle ethereum-waffle  


Delete the sample scripts in the contracts and scripts folders

Delete everything in `hardhat.config` and insert new stuff (just grabbed from GitHub)

Set up polygonscan account and app (get API key) and polygon(mumbai testnet) app on Alchemy (get RPC) and export private key from metamask for .env file.


Once the script is complete, deploy using:

% npx hardhat run scripts/deploy.js --network mumbai     

Grab the deployed contract address, then verify: 

% npx hardhat verify --network mumbai 0x019c58b1678E566d866c506827ba4813bF8B451b

Note that I had an issue with a .json file in artifacts causing problems.  The solution was to delete the artifacts folder, then run the deploy script again to recompile.  

Note, have to wait a few (5) confirmations between deploy and verify commands.

Check contract on mumbai.polygonscan.com 

WRITE TO CONTRACT using the "Write Contract" option under the contract tab!  This kinda works like remix, where you have input boxes appear for each of your functions and you can connect your MetaMask then conduct transactions.


CHALLENGE FOR WEEK3

On the mapping in ChainBattles (first mapping in the contract) he's just mapped a uint256 => uint256.  The challenge is to learn to map a uint256 to a struct!  

Need to track the following (not hard and fast rule)

// track levels
// track hp
// track strength
// strack speed

...then add a full list of stats to our character.  Figure out how to do pseudo random number generation in solidity (not ideal - should really use VRF Chainlink) and use it to figure out numbers for levels for hp, strength and speed then implement increases...








