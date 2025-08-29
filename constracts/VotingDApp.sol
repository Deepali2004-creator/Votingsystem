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
        // ✅ Safety checks
        require(!hasVoted[msg.sender], "You already voted.");
        require(!electionEnded, "Election has ended.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        // ✅ Record vote
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

    
    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        require(electionEnded, "Election has not ended yet.");

        uint winningVoteCount = 0;
        uint winningIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningIndex = i;
            }
        }

        winnerName = candidates[winningIndex].name;
        winnerVotes = candidates[winningIndex].voteCount;
    }
}

