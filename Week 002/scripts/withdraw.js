// scripts/withdraw.js

const hre = require("hardhat");
const abi = require("../artifacts/contracts/BuyMeACoffee.sol/BuyMeACoffee.json");

async function getBalance(provider, address) {
    const balanceBigInt = await provider.getBalance(address);
    return hre.ethers.utils.formatEther(balanceBigInt);
}

async function main() {
    // Get the contract that has been deployed to Goerli
    const contractAddress = "0xb0f704aCb296CD169f107690d6e298aDD63a0252";
    const contractABI = abi.abi;

    // Get the node connection and wallet connection
    const provider = new hre.ethers.providers.AlchemyProvider("goerli", process.env.GOERLI_API_KEY);

    // Ensure that the signer is the SAME address as the original contract deployer, or else this
    // script will fail with an error.
    const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

    // Adding alternative owner to withdrawals

    const alternativeAddress = new hre.ethers.Wallet(process.env.ALTERNATIVE_ADDRESS, provider)

    // Instantiate the connected contract
    const buyMeACoffee = new ethers.Contract(contractAddress, contractABI, signer );

    // Check starting balances
    console.log("current balance of owner: ", await getBalance(provider, signer.address), "ETH");
    console.log("current balance of alternative owner: ", await getBalance(provider, alternativeAddress.address), "ETH")
    const contractBalance = await getBalance(provider, buyMeACoffee.address);
    console.log("current balance of contract: ", await getBalance(provider, buyMeACoffee.address), "ETH");

    // Withdraw funds if there are funds to withdraw
    if (contractBalance !== 0.0) {
        console.log("Withdrawing Funds...");
        const withdrawTxn = await buyMeACoffee.withdrawTips();
        await withdrawTxn.wait();
    } else {
        console.log("No funds to withdraw");
    }

    // Check ending balance
    console.log("Current balance of owner: ", await getBalance(provider, signer.address), "ETH");
    console.log("Current balance of alternative address", await getBalance(provider, alternativeAddress.address), "ETH");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })