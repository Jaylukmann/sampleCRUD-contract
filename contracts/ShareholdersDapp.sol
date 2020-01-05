pragma solidity >=0.4.22 <0.6.0;
import "./ShareholdersDappStorage.sol";

contract BankersInvestorsContract is ShareholdersDappStorage{
    
    //STATE VARIABLE
     address owner;
     address investors;

    //MODIFIERS
    modifier onlyOwner() {
       require(msg.sender == owner,"Only the owner can update");
        _;
    }
     modifier onlyInvestor() {
       require(msg.sender == investors,"Only the owner can update");
        _;
    }
    
    //CONSTRUCTOR
    constructor () public {
        owner = msg.sender;
        roiRatio();
    }
    
//EVENTS
     event AddInvestor(address indexed owner, address indexed investor, bytes32 name);
    event Transfer(address indexed from, address indexed to, uint tokens);

     
    
    // *** GETTER METHODS ***
   function getInvestor(address _key) internal view returns(bytes32) {
        return investor[_key];
    }
    
    function getInvestment(address _investor) external view returns(uint) {
        return storeInvestment[_investor];
    }
    function getROI(address _investor) external view returns(uint ) {
        return storeROI[_investor];
    }
    function getAddress(address _addressToGet) external view returns(bytes32) {
        return storeAddress[_addressToGet];
    }
    function getBalanceOf(address balanceToGet) public view returns (uint) {
        return balances[balanceToGet];
    }
    

    // *** SETTER METHODS ***
   
 function addInvestor(address _newInvestorsAddress,bytes32 _name) external onlyOwner returns(bool) {
      InvestorsProfile memory investorr;
       investorr.name = _name;
       investorr.id = _newInvestorsAddress;
      investor[_newInvestorsAddress] = _name;
       emit AddInvestor(msg.sender,_newInvestorsAddress,_name);
        return true;
    }
    function setAddress(address _addressToSet, bytes32 _name)external  onlyOwner  {
        storeAddress[_addressToSet] = _name;
    }

    function roiRatio() private view onlyOwner returns(uint){
      uint roi = (uint(1)/uint(10));
      return roi;
    }
    function returnOnInvestment(uint _investment) public view onlyOwner onlyInvestor returns(uint){
      uint roi =(_investment * uint(10));
      return roi;
    }
     
    
    function transferToInvestor(address investor, uint _amount) external payable onlyOwner returns (bool) {
        require(balances[investor] <= balances[msg.sender],"There was an overflow");
        balances[msg.sender] = (balances[msg.sender] - (_amount));
        balances[investor] = (balances[investor] + (_amount));
        emit Transfer(msg.sender, investor, _amount);
        return true;
    }
    function transferToOutsiders(address _investor, address outsideReceiver, uint _amount) external payable onlyInvestor returns (bool) {
        require(balances[outsideReceiver] <= balances[msg.sender],"There was an overflow");
        balances[msg.sender] = (balances[msg.sender] - (_amount));
        balances[_investor] = (balances[_investor] + (_amount));
        emit Transfer(msg.sender, _investor, _amount);
        return true;
    }
    
    function addBalance(address holder, uint _balances) public view {
       (getBalanceOf(holder) + _balances);
    }

    // *** DELETE METHODS ***
    function deleteInvestor(address _key) external  onlyOwner  {
        delete investor[_key];
    }
     function deleteInvestment(address _key) external  onlyOwner  {
        delete storeInvestment[_key];
    }
    function deleteROI(address _key) external  onlyOwner  {
        delete storeROI[_key];
    }

    function deleteAddress(address _value) external  onlyOwner  {
        delete storeAddress[_value];
    }
    function deletebalances(address _key) external  onlyOwner  {
        delete balances[_key];
    }
}

