// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    address public storeAddress;
    mapping(string => uint256) public itemPrices; // Mapping to store item prices
    mapping(address => string[]) public redeemedItems; // Mapping to store redeemed items for each player

    event ItemRedeemed(address indexed player, string itemName, uint256 itemPrice);

    constructor(uint256 initialSupply, address _storeAddress) ERC20("DegenGamingToken", "DGT") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply);
        storeAddress = _storeAddress;
    }

    // Minting new tokens, only the owner can do this
    function mintToken(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Redeeming tokens for items in the in-game store
    function redeemToken(string memory itemName) public {
        uint256 itemPrice = itemPrices[itemName];
        require(itemPrice > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient balance to redeem");

        _transfer(msg.sender, storeAddress, itemPrice);
        redeemedItems[msg.sender].push(itemName);

        emit ItemRedeemed(msg.sender, itemName, itemPrice);
    }

    // Burning tokens
    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Transfer tokens
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        return super.transfer(to, amount);
    }

    // Set the store address (only the owner can do this)
    function setStoreAddress(address _storeAddress) public onlyOwner {
        storeAddress = _storeAddress;
    }

    // Set item price (only the owner can do this)
    function setItemPrice(string memory itemName, uint256 price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    // Get the redeemed items for a player
    function getRedeemedItems(address player) public view returns (string[] memory) {
        return redeemedItems[player];
    }
}
