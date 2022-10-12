const hre = require("hardhat");

async function main() {
  // Get the contract to deploy & then deploy
  const BuyMeACoffee = await hre.ethers.getContractFactory("BuyMeACoffee"); // gets the contract factory
  const buyMeACoffee = await BuyMeACoffee.deploy(); // create an instance of the factory and start a deploy
  await buyMeACoffee.deployed(); // wait until it's deployed
  console.log("BuyMeACoffee deployed to ", buyMeACoffee.address); // log that we've been deployed as set address
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
