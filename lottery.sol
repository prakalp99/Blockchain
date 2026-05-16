// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedLottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    function buyTicket() public payable {
        require(msg.value == 0.01 ether, "Ticket price is exactly 0.01 Ether");
        players.push(msg.sender);
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only the manager can pick the winner");
        require(players.length > 0, "No players in the pool");

        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players))) % players.length;
        address winner = players[randomIndex];

        players = new address[](0); // Reset pool
        payable(winner).transfer(address(this).balance); // Transfer pool funds
    }
}