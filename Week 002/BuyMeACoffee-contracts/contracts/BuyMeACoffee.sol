// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Switch this to your own contract address once deployed, for bookkeeping!
// Example Contract Address on Goerli: 0xDBa03676a2fBb6711CB652beF5B7416A53c1421D

contract BuyMeACoffee {
    // Event to emit when a memo is created
    event NewMemo (
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // Address of contract deployer. Marked as payable so that we
    // can withdraw to this address later.

    address payable owner;

    // List of all memos received from coffee purchases.
    Memo[] memos;

    constructor() {
        // Store the address of the deployer as a payable address.
        // When we withdraw funds, we'll withdraw here.
        owner = payable(msg.sender);
    }

    /**
    * @dev fetches all stored memos
    */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    /**
    * @dev buy a coffee for owner (sends an ETH tip and leaves a memo)
    * @param _name name of the coffee purchaser
    * @param _message a nice message from the purchaser
    */

    function buyCoffee(string memory _name, string memory _message) public payable {
        // Must accept more than 0 ETH for a coffee.
        require(msg.value > 0, "Amount must be more than 0");

        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a new memo event with details about the memo
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );

    }

    /**
    * @dev send the entire balance stored in this contract to the owner
    */

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

}

// CONTRACT HIGHLIGHTS

// When we deploy the contract, the constructor saves the address of the wallet that was responsible for deploying inside an owner variable as a payable address. This is useful for later when we want to withdraw any tips collected by the contract.

// The buyCoffee function is the most important function on the contract. It accepts two strings, a _name, and a _message, and it also accepts ether due to the payable modifier. It uses the _name and _message inputs to create a Memo struct that is stored on the blockchain.

// When visitors call the buyCoffee function, they must submit some ether due to the require(msg.value > 0) statement. The ether is then held on the contract balance until it is withdrawn.

// The memos array holds all of the Memo structs generated from coffee purchases.

// NewMemo log events are emitted every time a coffee is purchased. This allows us to listen for new coffee purchases from our frontend website.

// withdrawTips is a function that anyone can call, but will only ever send money to the original deployer of the contract.

// address(this).balance fetches the ether stored on the contract

// owner.send(...) is the syntax for creating a send transaction with ether

// the require(...) statement that wraps everything is there to ensure that if there are any issues, the transaction is reverted and nothing is lost
// that's how we get require(owner.send(address(this).balance))