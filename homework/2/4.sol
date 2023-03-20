// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract DevVoter {
    struct Voter {
        uint256 id;
        string name;
        address[] peoples;
    }
    //string is vote theme
    mapping(string => Voter[]) voters;

    function createVote(string memory _voteName, string[] memory _votes) public {
        require(voters[_voteName].length == 0, "Vote already exists");
        require(_votes.length > 0, "No votes to create");
        for (uint256 i = 0; i < _votes.length; i++) {
            voters[_voteName].push(Voter({
            id : i,
            name : _votes[i],
            peoples : new address[](0)
            }));
        }
    }

    function getVotesByVoteName(string memory _voteName) public returns (string[] memory) {
        string[] memory _votes = new string[](voters[_voteName].length);
        for (uint256 i = 0; i < voters[_voteName].length; i++) {
            Voter storage voter = voters[_voteName][i];
            _votes[i] = voter.name;
        }

        return _votes;
    }


    function vote(string memory _voteName, string memory _vote) public {
        require(voters[_voteName].length > 0, "Vote does not exist");
        for (uint i = 0; i < voters[_voteName].length; i++) {
            if (keccak256(abi.encodePacked(voters[_voteName][i].name)) == keccak256(abi.encodePacked(_vote))) {
                if (voters[_voteName][i].peoples.length > 0) {
                    for (uint j = 0; j < voters[_voteName][i].peoples.length; j++) {
                        require(voters[_voteName][i].peoples[j] != msg.sender, "You have already voted");
                    }
                }
                voters[_voteName][i].peoples.push(msg.sender);
            }
        }
    }

    //    функцию для извлечения результатов конкретной сессии голосования.
    function countVotes(string memory _voteName, string memory _vote) public view returns (string memory, string memory, uint256){
        uint count = 0;
        for (uint i = 0; i < voters[_voteName].length; i++) {
            if (keccak256(abi.encodePacked(voters[_voteName][i].name)) == keccak256(abi.encodePacked(_vote))) {
                count = voters[_voteName][i].peoples.length;
            }
        }
        return (_voteName, _vote, count);
    }

    function countAllVotes(string memory _voteName) public returns (Voter[] memory){

        return voters[_voteName];
    }

}
