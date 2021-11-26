pragma solidity ^0.5.0;

contract DeferredEquityPlan {
    uint public fakenow = now;
    address human_resources;
    address payable employee;
    bool active = true;
    
    // set total shares to distribute and annual distribution of shares
    uint total_shares = 1000;
    uint annual_distribution = 250;
    
    // permanently store the contract's start date and set the unlock date to 365 days from now
    uint public start_date = fakenow;
    uint unlock_time = fakenow + 365 days;
    
    uint public distributed_shares;
    
    constructor (address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }
    
    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");
        
        require(unlock_time <= fakenow, "Shares must be vested.");
        require(distributed_shares < total_shares, "No shares to distribute.");
        
        // calculate next year's distribution date
        unlock_time = fakenow + 365 days;
        
        // set new value for distributed_shares
        distributed_shares = (fakenow - start_date) / 365 days * annual_distribution;
        
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }
    
    function fastforward() public {
        fakenow += 100 days;
    }
    
    function deactivateContract() public {
        active = false;
    }
    
    function reactivateContract() public {
        active = true;
    }
}
