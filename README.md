# Degen Token

DegenGamingToken (DGT) is an ERC20 token designed to empower the play-to-earn gaming landscape. This smart contract provides a foundational infrastructure for games and applications built on the Ethereum blockchain, allowing users to earn, burn, and transfer DGT tokens within the gaming ecosystem.

## Getting Started

While not strictly necessary for basic use, understanding Solidity can provide deeper insights into the contract's functionality.

### Executing program

To run this program, you can use Remix IDE to perform the required steps. Make sure to save all the codes for it to run smoothly.

```javascript
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
```

Use a Solidity compiler to compile the DegenGamingToken.sol code into bytecode understandable by the Ethereum Virtual Machine (EVM).

Ensure your MetaMask wallet is configured to interact with the Fuji Testnet.

Use your MetaMask wallet or a tool like Remix IDE to interact with the deployed contract's functions. Here's a breakdown of some key functions (assuming you have obtained the contract address):

transferTokens(address recipient, uint256 amount): Allows transferring DGT tokens to another wallet address (requires sufficient DGT balance).

mint(address to, uint256 amount): For the contract owner (requires ownership privileges), this function mints new DGT tokens and assigns them to a specified address.

redeem(uint256 amount) / burn(uint256 amount): Allows users to burn (destroy) a portion of their own DGT tokens.

## Authors

Kleyn

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
