// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    constructor(uint256 initialSupply, address owner) ERC20("DegenGamingToken", "DGT") Ownable(owner) {
    _mint(owner, initialSupply);
    }

    // Minting new tokens, only the owner can do this
    function mintToken(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Redeeming tokens (burning tokens)
    function redeemToken(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Burning tokens
    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Transfer tokens
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
        return true;
    }
}
