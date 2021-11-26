pragma solidity ^0.5.0;

contract TieredProfitSplitter {
    address payable CEO;
    address payable CTO;
    address payable Bob;
    
    constructor(address payable _one, address payable _two, address payable _three) public {
        CEO = _one;
        CTO = _two;
        Bob = _three;
    }
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    function deposit() public payable {
        uint points = msg.value/100;
        uint total;
        uint amount;
        
        // Calculate and transfer the distributed percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points*60;
        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;
        // Step 3: Transfer the `amount` to the employee
        CEO.transfer(amount);
        
        amount = points*25;
        total += amount;
        CTO.transfer(amount);
        
        amount = points*14;
        total += amount;
        Bob.transfer(amount);
        
        // Send the remaining wei to the CEO
        CEO.transfer(msg.value-total);

    }
    
    function() external payable {
        deposit();
    }
}