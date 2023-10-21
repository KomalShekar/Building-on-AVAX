// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20, Ownable(msg.sender) {
    mapping(uint256 => uint256) public itemPrices; // Mapping of item IDs to their prices

    constructor() ERC20("DegenToken", "DGN") {
        // Mint an initial supply of tokens to the contract deployer (owner)
        _mint(msg.sender, 1000000 * 10 ** uint(decimals())); // Adjust the initial supply as needed
    }


    // Mint new tokens, only callable by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Transfer tokens to another address with a touch of magic
    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid destination, a wizard never sends to null!");
        require(balanceOf(msg.sender) >= amount, "Insufficient magical balance");
        _transfer(msg.sender, to, amount);
    }

    // Redeem tokens for enchanted items in the mystical store
    function redeemTokens(uint256 itemId) public {
        require(itemPrices[itemId] > 0, "Invalid item, maybe it vanished into another dimension?");
        uint256 price = itemPrices[itemId];
        require(balanceOf(msg.sender) >= price, "Insufficient mystical balance");

        // Implement logic to summon the enchanted item to the player here.
        // For this example, we'll simply cast a spell and deduct the tokens from the player's balance.
        _burn(msg.sender, price);
    }

    // Add an item with a specific enchanting price to the mystical store
    function addItemToStore(uint256 itemId, uint256 price) public onlyOwner {
        itemPrices[itemId] = price;
    }

    // Check the magical token balance of an enigmatic address
    function getMagicalTokenBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Burn tokens that are no longer needed, let the magical flames consume them
    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient magical balance");
        _burn(msg.sender, amount);
    }
}
