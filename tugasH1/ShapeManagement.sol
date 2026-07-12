// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// LIVE CODING #2 — Hari 2
// Studi kasus: Shape, Circle, Rectangle (inheritance + interface)

interface IShape {
    // Deklarasi fungsi area yang wajib di-implementasikan oleh kontrak turunan
    function area() external view returns (uint);
}

// Abstract contract karena tidak mengimplementasikan fungsi area() secara langsung
abstract contract Shape is IShape {
    string public name;
}

// Kontrak Lingkaran yang mewarisi sifat dari Shape
contract Circle is Shape {
    uint public radius;

    // Constructor untuk inisialisasi nama dan radius lingkaran
    constructor(uint _radius) {
        name = "Circle";
        radius = _radius;
    }

    // Mengimplementasikan rumus luas lingkaran (3 * r * r sesuai instruksi soal)
    function area() external view override returns (uint) {
        return 3 * radius * radius;
    }
}

// Kontrak Persegi Panjang yang mewarisi sifat dari Shape
contract Rectangle is Shape {
    uint public sideA;
    uint public sideB;

    // Constructor untuk inisialisasi nama dan panjang kedua sisi
    constructor(uint _a, uint _b) {
        name = "Rectangle";
        sideA = _a;
        sideB = _b;
    }

    // Mengimplementasikan rumus luas persegi panjang (sisiA * sisiB)
    function area() external view override returns (uint) {
        return sideA * sideB;
    }
}
