const hre = require("hardhat");

const main = async () => {
    try {
        const nftContractFactory = await hre.ethers.getContractFactory("ChainBattles"); // creates contract factory!
        const nftContract = await nftContractFactory.deploy(); // create our contract (note deploy!)
        await nftContract.deployed(); // wait for the above to finish on the blockchain
        console.log("Contract deployed to: ", nftContract.address); // remember can use console.log to help troubleshoot
        process.exit(0); // if everything worked out OK, then quit function. (waits for all async functions to finish, then quits)
    } catch (error) {
        console.log('here');
        console.log(error);
        process.exit(1); // node exits with uncaught fatal exception

    }
}

main(); // gotta have this in order to deploy!!! Actually calls the function lol