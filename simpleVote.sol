pragma solidity ^0.4.0; 
contract simpleVote
{
    struct Voter{
        bool voted;
        bool activated;
        
    }
    uint candidates;
    mapping (address=> Voter) voters;
    uint  [] public voteResult ;
    address voteCreator;
    function simpleVote(uint _candidates)
    {
        candidates=_candidates;
        voteResult.length=_candidates;
        voteCreator=msg.sender;
        for(uint i=0;i<_candidates;i++)
        {
            voteResult[i]=0;
        }
        
    }
    modifier hasBeenGranted()
    {
        require(!voters[msg.sender].activated);
        _;
    }
    modifier isGranted()
    {
        require(voters[msg.sender].activated);
        _;
    }
    modifier hasVote()
    {
        require(!voters[msg.sender].voted);
        _;
    }
     modifier voteInrange(uint _voteFor)
    {
        require(_voteFor<candidates && _voteFor>=0);
        _;
    }
    modifier isChair()
    {
        require(msg.sender==voteCreator);
        _;
    }
    function getVoteAccess() public hasBeenGranted
    {
        voters[msg.sender].activated=true;
    }
    function vote(uint voteFor) public hasVote voteInrange(voteFor) isGranted
    {
        voteResult[voteFor]+=1;
        voters[msg.sender].voted=true;
    }
   
    function freeze() public isChair returns(uint ) 
    {
        uint winner=0;a
        for (uint i=1;i<voteResult.length;i++)
        {
            if(voteResult[i]>winner)
            {
                winner=i;
            }
        }
        return winner;
    }
}