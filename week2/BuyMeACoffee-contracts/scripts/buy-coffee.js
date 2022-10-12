const hre = require("hardhat");

// Returns the Ether balance of a given address.
async function getBalance(address) {
  const balanceBigInt = await hre.ethers.provider.getBalance(address); // provider is a node (a communication with a blockchain)
  return hre.ethers.utils.formatEther(balanceBigInt); // takes in a bigInt and spits out a human readable nicer version of that bigInt
}

// Logs the Ether balances for a list of addresses.
async function printBalances(addresses) {
  let idx = 0;
  for (const address of addresses) {
    console.log(`Address ${idx} balance: `, await getBalance(address));
    idx++;
  }
}

// Logs the memos stored on-chain from coffee purchases.
async function printMemos(memos) {
  for (const memo of memos) {
    const timestamp = memo.timestamp;
    const tipper = memo.name;
    const tipperAddress = memo.from;
    const message = memo.message;
    console.log(
      `At ${timestamp}, ${tipper} (${tipperAddress}) said: "${message}"`
    );
  }
}

async function main() {
  // Get example accounts
  const [owner, tipper, tipper2, tipper3] = await hre.ethers.getSigners(); // getSigners just creates example account array (accounts contain 10k eth to start out with)

  // Get the contract to deploy & then deploy
  const BuyMeACoffee = await hre.ethers.getContractFactory("BuyMeACoffee"); // gets the contract factory
  const buyMeACoffee = await BuyMeACoffee.deploy(); // create an instance of the factory and start a deploy
  await buyMeACoffee.deployed(); // wait until it's deployed
  console.log("BuyMeACoffee deployed to ", buyMeACoffee.address); // log that we've been deployed as set address

  // check balances before the coffee purchases
  const addresses = [owner.address, tipper.address, buyMeACoffee.address];
  console.log("== start ==");
  await printBalances(addresses);

  // buy the owner a few coffees
  const tip = { value: hre.ethers.utils.parseEther("1") }; // set the tip value
  await buyMeACoffee.connect(tipper).buyCoffee("Dave", "Great Work!", tip); // buyMeACoffee is our connected instance of the function, so let's connect to it with the different addresses and tip!
  await buyMeACoffee.connect(tipper2).buyCoffee("Steve", "Lovely Stuff!", tip); // not sure why/how we add "tip" here?
  await buyMeACoffee.connect(tipper3).buyCoffee("Sandra", "Oooh nice!", tip);

  // check balances after coffee purchase
  console.log("== bought coffee ==");
  await printBalances(addresses);

  // withdraw funds
  await buyMeACoffee.connect(owner).withdrawTips();

  // check balance after withdraw
  console.log("== withdraw ==");
  await printBalances(addresses);

  // read all the memos left for the
  console.log("== memos ==");
  const memos = await buyMeACoffee.getMemos();
  printMemos(memos);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
