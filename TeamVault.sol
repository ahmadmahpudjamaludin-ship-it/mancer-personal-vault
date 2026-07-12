// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// LATIHAN MANDIRI — Hari 3
// Studi kasus: TeamVault (Ownable + Role-Based Access Control)

contract TeamVault {
    address public owner;
    mapping(address => bool) public isMember;

    // Set pembuat kontrak sebagai owner utama
    constructor() {
        owner = msg.sender;
    }

    // Modifier khusus untuk membatasi akses hanya untuk owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Modifier khusus untuk membatasi akses hanya untuk anggota tim
    modifier onlyMember() {
        require(isMember[msg.sender], "Not a member");
        _;
    }

    // Fungsi untuk menambah anggota tim (hanya bisa dipanggil owner)
    function addMember(address _user) public onlyOwner {
        isMember[_user] = true;
    }

    // Fungsi deposit (siapa aja boleh nyetor, saldo otomatis masuk lewat msg.value)
    function deposit() public payable {
        // Kosong aja, ETH otomatis kesimpen lewat msg.value
    }

    // Fungsi withdraw untuk anggota mengambil dana
    function withdraw(uint amount) public onlyMember {
        require(amount <= address(this).balance, "Insufficient vault balance");
        
        // Transfer ETH menggunakan low-level call
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "Transfer failed");
    }

    // Fungsi untuk cek total saldo di dalam kontrak vault ini
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
