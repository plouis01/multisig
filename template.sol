// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(address indexed owner,uint indexed txIndex,address indexed to,uint value,bytes data);
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);
    
    //dynamic array containint the list of owners
    address[] public owners;

    //create a mapping so addresses can interact with this wallet.  bool is used to determine is the address enabled or disabled
    mapping(address => bool) public isOwner;

    //this is the number of signatures we need to sign the transaction
    uint public numConfirmationsRequired;

    //create a struct to represent a transaction that is submitted for others to approve.  
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    //mapping from tx index to owner address to bool
    mapping(uint => mapping(address => bool)) public isConfirmed;

    //dynamic array containint the list of transactions
    Transaction[] public transactions;

    //in order to interact with the wallet you need to be the owner so added a require statement then execute the function _;
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    //check if tx exist
    modifier txExists(uint _txIndex) {}

    //check if tx is pending
    modifier notExecuted(uint _txIndex) {}

    //check if msg.sender already confirm this tx
    modifier notConfirmed(uint _txIndex) {}

    //initiate the contract, check parameters & add owners
    constructor(address[] memory _owners, uint _numConfirmationsRequired) {}

    //anyone can deposit funds into the wallet and emit an event called Deposit ~ same as fallback but without calldata
    receive() external payable {}

    //submit a new transaction
    function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) public onlyOwner {}

    //confirm a transaction
    function confirmTransaction(uint _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
        notConfirmed(_txIndex) {}

    //execute a transaction if it meets minimum required signatures/confirmation 
    function executeTransaction(uint _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex) {}

    //Unconfirm a transaction
    function revokeConfirmation(uint _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex) {}

    //get a list of owners 
    function getOwners() public view returns (address[] memory) {}

    //get the number of transactions (pending & executed)
    function getTransactionCount() public view returns (uint) {}

    //get a transactions from its index
    function getTransaction(uint _txIndex)
        public
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
    {}
}
