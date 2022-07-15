// scripts/buy-coffee.js

const hre = require("hardhat");

// Returns the Ether balance of a given address
async function getBalance(address) {
    const balanceBigInt = await hre.waffle.provider.getBalance(address);
    return hre.ethers.utils.formatEther(balanceBigInt);
}

// Logs the Ether balances for a list of addresses

async function printBalances(addresses) {
    let idx = 0;
    for (const address of addresses) {
        console.log(`Address ${idx} balance:`, await getBalance(address));
        idx ++;
    }
}

// Logs the memos stored on-chain from coffee purchases
async function printMemos(memos) {
    for (const memo of memos) {
        const timestamp = memo.timestamp;
        const tipper = memo.name;
        const tipperAddress = memo.from;
        const message = memo.message;
        console.log(`At ${timestamp}, ${tipper} (${tipperAddress}) said: "${message}"`)
    }
}

async function main() {
    // Get the example accounts we will be working with.
    const [owner, tipper, tipper2, tipper3] = await hre.ethers.getSigners();
}
