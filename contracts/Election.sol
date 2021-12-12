pragma solidity 0.5.16;

contract Election {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts address that have been voted
    mapping(address => bool) public voters;
    // Store Candidates
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;
    // voted event
    event votedEvent 
    (
        uint indexed _candidateId
    );
    

    //To add new candidates
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        }

    constructor () public {
        addCandidate("IIIT_V Candidate");
        addCandidate("IIT_GN Candidate");
        addCandidate("DAIICT_GN Candidate");
        addCandidate("NIRMA_AMD Candidate");
        addCandidate("PDPU_GN Candidate");
        addCandidate("ADANI_AMD Candidate");
        addCandidate("AU_AMD Candidate");
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
       emit votedEvent(_candidateId);
    }
}