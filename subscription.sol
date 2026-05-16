// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionService {
    uint256 public constant SUBSCRIPTION_COST = 0.01 ether;
    uint256 public constant DURATION = 30 days;

    mapping(address => uint256) public subscriptionExpires;

    function subscribe() public payable {
        require(msg.value == SUBSCRIPTION_COST, "Incorrect subscription fee");

        if (block.timestamp > subscriptionExpires[msg.sender]) {
            subscriptionExpires[msg.sender] = block.timestamp + DURATION;
        } else {
            subscriptionExpires[msg.sender] += DURATION; 
        }
    }

    function hasAccess(address _user) public view returns (bool) {
        return block.timestamp < subscriptionExpires[_user];
    }
}