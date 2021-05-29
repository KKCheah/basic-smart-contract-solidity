pragma solidity >= 0.7.5;

contract Bank {
    
    //initialize mapping
    mapping(address => uint) balance;
    address owner;
    
    constructor(){
        owner = msg.sender;
    }
    
    // function to add balance to an address
    function addBalance(uint _toAdd) public returns (uint) {
        //only contract deployment ownder can access addBalance function
        require(msg.sender == owner);
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }
    
    // function that allows us to view current address balance
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    // public function that calls private function to perform transfer
    // send input from this function and call private function
    function transfer(address recipient, uint amount) public {
        //check balance of msg.sender
        require(balance[msg.sender]>= amount, "INSUFFICIENT BALANCE");
        
        //prevent funds from transferring back to onsself
        require(msg.sender != recipient, "sENDING AMOUNT TO ONESELF INSTEAD OF ANOTHER ADDRESS");
        
        //test of assertance
        uint previousSenderBalance = balance[msg.sender];
        
        //call the private transfer function and input the msg.sender, recipient and amount to be transferred
        _transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount); //this has to be correct at all times
        
        //event logs and further checks
    }
    
    // obtain data from the transfer function to perform the flow of balance between
    // sender and receiver
    function _transfer (address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
    
}