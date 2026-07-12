// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// LATIHAN MANDIRI — Hari 3
// Studi kasus: TeamVaultViewer (Contract Interactions lewat interface)

interface IVault {
    function deposit() external payable;
    function getBalance() external view returns (uint);
    function isMember(address _user) external view returns (bool);
}

contract TeamVaultViewer {
    
    // Memanggil fungsi getBalance() milik kontrak TeamVault dari luar
    function checkBalance(address vaultAddress) external view returns (uint) {
        return IVault(vaultAddress).getBalance();
    }

    // Memanggil mapping/getter isMember milik kontrak TeamVault dari luar
    function checkMembership(address vaultAddress, address user) external view returns (bool) {
        return IVault(vaultAddress).isMember(user);
    }

    // Menyetorkan dana (fund) ke TeamVault lewat perantara kontrak ini
    function fundVault(address vaultAddress) external payable {
        IVault(vaultAddress).deposit{value: msg.value}();
    }
}
