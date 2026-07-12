// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// LIVE CODING #1 — Hari 2
// Studi kasus: Student Registry (struct + mapping + array)

contract StudentRegistry {
    
    // Struct untuk menyimpan data profile mahasiswa
    struct Student {
        string name;
        uint age;
        bool isActive;
    }

    // Mapping untuk mencari data Student berdasarkan alamat wallet
    mapping(address => Student) public students;
    
    // Array untuk menampung semua alamat wallet mahasiswa yang terdaftar (biar bisa di-iterasi)
    address[] public studentAddresses;

    // Fungsi untuk mendaftarkan mahasiswa baru
    function registerStudent(string memory _name, uint _age) public {
        // Menyimpan data student baru ke dalam mapping
        students[msg.sender] = Student(_name, _age, true);
        
        // Memasukkan address pendaftar ke dalam array
        studentAddresses.push(msg.sender);
    }

    // Fungsi untuk mengambil total jumlah mahasiswa yang terdaftar
    function getStudentCount() public view returns (uint) {
        return studentAddresses.length;
    }

    // Fungsi untuk menonaktifkan status aktif mahasiswa tertentu
    function deactivateStudent(address _student) public {
        students[_student].isActive = false;
    }
}
