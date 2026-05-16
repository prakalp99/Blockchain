// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public admin;
    uint256 public goal;
    uint256 public deadline;
    uint256 public totalRaised;
    mapping(address => uint256) public contributions;

    constructor(uint256 _goal, uint256 _durationInSeconds) {
        admin = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _durationInSeconds;
    }

    function donate() public payable {
        require(block.timestamp < deadline, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;
    }

    function withdrawFunds() public {
        require(block.timestamp >= deadline, "Campaign is still ongoing");
        require(totalRaised >= goal, "Funding goal was not met");
        require(msg.sender == admin, "Only admin can withdraw total raised funds");

        payable(admin).transfer(address(this).balance);
    }

    function refund() public {
        require(block.timestamp >= deadline, "Campaign is still ongoing");
        require(totalRaised < goal, "Goal was met, refunds unavailable");
        
        uint256 amountToRefund = contributions[msg.sender];
        require(amountToRefund > 0, "No contributions found to refund");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amountToRefund);
    }
}