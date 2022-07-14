Alchemy - The Road to Web3 - Week 1 Notes

What do you need to developer a smart contract?

- Solidity
- A Node (Alchemy)
- A Developer Environment
- Cryptocurrency to pay the gas fees

What will you learn?

- What is a smart contract and what do you need to develop one?
- How to write an NFT smart contract?
- How to get free test ETH?
- How to use Alchemy?
- How do deploy to the blockchain?
- Interact with your NFTs on Open Sea

OpenZeppelin Contract Wizard

- Go to openzeppelin.com/contracts and click on Get Started.
- Click on Wizard on the left hand side.
- We will be working with NFTs, so click on ERC721.
- Fill in the name and symbol.
- Ignore the Base URI for now.
- Click mintable
- Click Auto Increment IDs
- Click Inumerable
- Click URI Storage

Navigate to Remix.Ethereum.org (You can use the button on OpenZeppelin)

Remix will be what we use to compile and deploy this contract to the blockchain.

Refer to Week-001.sol code for notes on this smart contract

After the smart contract is built and modified with the changes from the video, create/log into your Alchemy account.

Create a new project and add all necessary details.

Copy the HTTP URL from the Keys section

Open metamask and add the Alchemy Rinkeby RPC

Go to rinkebyfaucet.com and request test ETH 

Open remix and compile the smart contract

Deploy this smart contract to Rinkeby through Injected Web3

Once your contract is deployed through Remix, click on the Deployed Contracts dropdown.

Orange = Writing to the blockchain

Blue = Reading from the blockchain

Now we need to create our NFT metadata

Go to the OpenSea MetaData standards page (https://docs.opensea.io/docs/metadata-standards) and copy the Metadata structure.

Paste the metadata structure into a text editor, edit the description and URL.

Now we will upload the image through filebase.com

Log into Filebase, Click on buckets, and create a new bucket

Upload the photo you would like to use

Edit the metadata in your json file to whatever you would like - make sure to include a link to the img you just uploaded.

Go back to filebase and we will need to upload this data.

Upload the json metadata to filebase

Once this uploaded, copy the IPFS CID

Go to remix and paste the IPFS CID into the safemint function along with
your wallet address. Click transact and mint to the blockchain.

You can check if it was successful by pasting your address into the balanceOf field. This will tell you how many NFTs you have in your wallet. In this case it should return a uint of 1.

