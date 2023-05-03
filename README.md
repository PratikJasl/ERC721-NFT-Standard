# ERC721-NFT-Standard
ERC721 token standard with safeties to prevent NFT lockouts in smart contracts

## Description 📌
ERC721 is an ERC20 token where each token has a unique ID and can have an URL for more Meta Data.
Simply speaking NFTs are tokens that have a unique token ID and can have data that is mutable.
In this project we implement an NFT token, with functionalities like Role based access control,
pausibility and prevention against NFT lockouts in smart contracts.
This project is divided into 4 Contracts named:
* ERC721.sol
* ERC721 Receiver.sol
* Access Control.sol
* Pausable.sol

## Algorithm 📌
* Upon Deployment of the Smart Contract, the user must specify details like NFT name, symbol, max supply, and Base URI.
* The address deploying the smart contract must become the owner.
* Functions to check the Balances of addresses and the owner of a particular TokenID.
* A function to Safe transfer NFT, ensuring safeties to prevent NFT lockouts in contracts.
* While Transfer of an NFT to a Contract address, then NFT lockout prevention must be checked.
* A function to safely mint token, ensuring safeties to prevent NFT lockouts in contracts.
* A function to Burn minted Tokens.
* A Contract to provide Role Based Access Control.
* A Contract to provide Pausable Functionality.
* A Contract implementing IERC721Receiver standards.


## Technology Stack📌
* Solidity
* Ganache
* Hardhat
* Ether.js
* Remix IDE

## Instructions & Information📌
1) Open [Remix IDE](https://remix.ethereum.org).
2) Create a new folder.
3) Inside the folder, create 4 solidity files with extension [.sol].
4) Copy paste code from github to the newly created .sol file.
5) Start Ganache.
6) Select Quickstart Ethereum option.
7) In Remix, select DEPLOY & RUN TRANSACTIONS.
8) In Environment dropdown, select Dev - Ganache Provider.
9) In Ganache JSON-RPC Endpoint, enter ganache rpc server. You will find rpc server details in ganache.
10) Compile & Deploy ERC720.sol in remix.

