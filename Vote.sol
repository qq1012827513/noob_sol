// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Vote {
    struct Voter {
        uint tickets;
        bool voted;  // if true, that person already voted
    }
    mapping (address => Voter) voters;
    Proposal[] tickets;
    struct Proposal {
        string name;
        uint count;
    }
    address owner;
    event QueryResult(string msg);

    constructor(string[] memory proposal) {
        owner = msg.sender;
        for(uint i = 0; i < proposal.length; i ++) {
            tickets.push(Proposal({name: proposal[i], count: 0}));
        }
    }

    function addVoter(address voterAddress) public {
        require(owner == msg.sender, "only owner can call");
        voters[voterAddress] = Voter({tickets: 1,voted: false});
    }

    function vote(uint t) public {
        require(voters[msg.sender].tickets > 0, "you can`t vote");
        require(!voters[msg.sender].voted, "you have voted");
        require(t < tickets.length, "there is no proposal here");
        voters[msg.sender].voted = true;
        tickets[t].count = tickets[t].count + voters[msg.sender].tickets;
    }

    function showResult() public returns (string memory){
        emit QueryResult("someone get the result");
        uint maxCount;
        string memory maxName;
        for (uint i = 0; i < tickets.length; i++) {
            uint count = tickets[i].count;
            if(count > maxCount) {
                maxCount = count;
                maxName = tickets[i].name;
            }
        }
        return maxName;
    }
}