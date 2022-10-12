## Week 2 Notes

_HOW TO GET PRETTIER TO AUTO FORMAT VSCODE?_

Install npm (node package manager) and nvm (node version manager):

https://github.com/nvm-sh/nvm

Create a new directory - `BuyMeACoffee-Contracts` and cd into this.

Generate a new empty npm project:

% npm init -y

Launch HardHat and create a basic sample project. Hardhat is an Ethereum development environment for professionals.

% npx hardhat (javascript project, say yes to all the options, this installs a bunch of useful packages)

Note that we have to wrap `msg.sender` (your address) in the `payable` keyword (ensure the address can be paid?)

Note that a constructor will only ever get run once. In this example, the owner address is set at the start and never changes.

hre is hardhat runtime environment.  
ethers is a complete js library for interacting with the Ethereum blockchain and its ecosystem.

Note that I need to understand exactly what getContractFactory is doing

Compile and run the script with:

% npx hardhat run scripts/buy-coffee.js

Note that when we do the first compile and run (around 36 mins in the video), had to add some stuff to the hardhat.config.js file and swap out waffle for ethers (see this post:https://discordapp.com/channels/735965332958871634/964536098267217951/1001865742003732594). Now it works!

hardhat.config.js is where we define our networks. We can choose between different networks if we like. Also introduce the dotenv file, so that we can keep our private keys/urls separate and secret.

Need to also install dotenv package
% npm install dotenv

Run script:
npx hardhat run scripts/deploy.js --network goerli

NOW FRONT END STUFF:

Log into replit https://replit.com/~

Note that I have to hit the "Open in a new tab" button to move the website out of replit in order for metamask to be recognized and actually connect when I hit the "connect" button.

Useful docs for metamask API stuff
https://docs.metamask.io/guide/ethereum-provider.html

CHALLENGE 1 (Backend)

Make it so that the owner can allow the owner address to be updated i.e. to allow tips to be withdrawn to another address

CHALLENGE 2 (Both backend and frontend)

Make it so there is an option to buy a "large" coffee.

Note: need to make sure you don't create too many memos!!! Seems to be OK when page first loaded?!

Createa and run withdraw script to withdraw all tips from account:

% npx hardhat run scripts/withdraw.js


Remember, when updating and redploying a Smart Contract, you need to

% npx hardhat run scripts/deploy.js --network goerli

Then, in Replit, update the contract address and upload the new ABI file (look in artifacts/contracts/BuyMeACoffee.sol/BuyMeACoffee.json)

Useful video on ownership transfer
https://www.youtube.com/watch?v=QEJYSuyYOfw