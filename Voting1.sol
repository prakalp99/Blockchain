// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public admin;
    bool public votingActive;
    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
        votingActive = false; 
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidates.push(Candidate({name: _name, voteCount: 0}));
    }

    function startVoting() public onlyAdmin {
        votingActive = true;
    }

    function endVoting() public onlyAdmin {
        votingActive = false;
    }

    function vote(uint256 _candidateIndex) public {
        require(votingActive, "Voting period is not active");
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate index");

        candidates[_candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getVoteCount(uint256 _candidateIndex) public view returns (uint256) {
        return candidates[_candidateIndex].voteCount;
    }
}