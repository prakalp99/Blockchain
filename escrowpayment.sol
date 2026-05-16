// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EscrowSystem {
    address public buyer;
    address public seller;
    uint256 public releaseDeadline;
    bool public buyerApproved;
    bool public sellerApproved;
    bool public fundsReleased;

    constructor(address _seller, uint256 _disputePeriodSeconds) payable {
        buyer = msg.sender;
        seller = _seller;
        releaseDeadline = block.timestamp + _disputePeriodSeconds;
        fundsReleased = false;
    }

    function approveRelease() public {
        if (msg.sender == buyer) buyerApproved = true;
        if (msg.sender == seller) sellerApproved = true;

        if (buyerApproved && sellerApproved) {
            executePayout();
        }
    }

    function claimTimeoutPayout() public {
        require(block.timestamp >= releaseDeadline, "Deadline hasn't passed");
        executePayout();
    }

    function executePayout() private {
        require(!fundsReleased, "Funds already claimed");
        fundsReleased = true;
        payable(seller).transfer(address(this).balance);
    }
}