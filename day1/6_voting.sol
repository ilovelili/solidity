// SPDX-License-Identifier: ISC
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 votes;
    }

    struct Ballot {
        uint256 id;
        string name;
        Candidate[] candidates;
        uint256 end;
    }

    mapping(uint256 => Ballot) ballots;
    mapping(address => bool) voters; // people who can vote
    /*ballotId*/
    mapping(address => mapping(uint256 => bool)) votes;

    uint256 private nextBalletId = 1;

    address admin;

    constructor() {
        admin = msg.sender;
    }

    function addVoters(address[] calldata _voters) external onlyAdmin() {
        for (uint256 i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = true;
        }
    }

    function createBallot(
        string calldata name,
        string[] calldata candidateNames,
        uint256 bufferTime
    ) external onlyAdmin() {
        ballots[nextBalletId].id = nextBalletId;
        ballots[nextBalletId].name = name;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            ballots[nextBalletId].candidates.push(
                Candidate(i, candidateNames[i], 0)
            );
        }
        ballots[nextBalletId].end = block.timestamp + bufferTime;
        nextBalletId++;
    }

    function vote(uint256 ballotId, uint256 candidateId) external {
        require(
            block.timestamp < ballots[ballotId].end,
            "can only vote until ballot end date"
        ); // block
        require(voters[msg.sender], "you cannot vote");
        require(
            !votes[msg.sender][ballotId],
            "voter can only vote once for a ballot"
        );

        votes[msg.sender][ballotId] = true;
        ballots[ballotId].candidates[candidateId].votes++;
    }

    function results(uint256 ballotId)
        external
        view
        returns (Candidate[] memory)
    {
        require(
            block.timestamp > ballots[ballotId].end,
            "cannot see the ballot result before ballot end"
        );
        return ballots[ballotId].candidates;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "go away");
        _; // placeholder
    }
}
