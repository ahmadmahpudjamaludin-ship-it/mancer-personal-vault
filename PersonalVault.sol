// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PersonalVault {
    address public owner;           // Who owns this vault
    uint256 public unlockTime;      // When funds become available
    
    // Events
    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(uint256 amount, uint256 timestamp);
    event LockExtended(uint256 newUnlockTime);
    
    // Custom errors
    error FundsLocked();
    error NotOwner();
    error InvalidUnlockTime();
    error ZeroBalance();

    // Access Control Modifier
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    // Constructor - Set owner and initial lock time
    constructor(uint256 _unlockTime) payable {
        if (_unlockTime <= block.timestamp) revert InvalidUnlockTime();
        owner = msg.sender;
        unlockTime = _unlockTime;
        
        // If ETH is sent during deployment, track it as a deposit
        if (msg.value > 0) {
            emit Deposit(msg.sender, msg.value);
        }
    }

    // 1. Deposit: Owner or anyone can add ETH to the vault
    function deposit() public payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 2. Withdraw: Owner retrieves all funds after lock period expires
    function withdraw() public onlyOwner {
        if (block.timestamp < unlockTime) revert FundsLocked();
        
        uint256 amount = address(this).balance;
        if (amount == 0) revert ZeroBalance();

        // Checks-Effects-Interactions Pattern (Emit event before external call)
        emit Withdrawal(amount, block.timestamp);

        // Safe ETH transfer using low-level call
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // 3. Extend Lock: Owner extends the lock period (cannot shorten)
    function extendLock(uint256 newTime) public onlyOwner {
        if (newTime <= unlockTime) revert InvalidUnlockTime();
        
        unlockTime = newTime;
        emit LockExtended(newTime);
    }
}
