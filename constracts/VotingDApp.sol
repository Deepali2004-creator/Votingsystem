// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingDApp {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin;
    bool public electionEnded;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function vote(uint candidateIndex) public {
        require(!hasVoted[msg.sender], "You already voted.");
        require(!electionEnded, "Election has ended.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
    }

    function getCandidate(uint index) public view returns (string memory name, uint votes) {
        require(index < candidates.length, "Invalid index.");
        Candidate memory candidate = candidates[index];
        return (candidate.name, candidate.voteCount);
    }

    function endElection() public {
        require(msg.sender == admin, "Only admin can end election.");
        electionEnded = true;
    }
}
