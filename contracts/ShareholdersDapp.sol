pragma solidity >=0.4.22 <0.6.0;
import "./ShareholdersDappStorage.sol";

contract BankersInvestorsContract is ShareholdersDappStorage{
    //STATE VARIABLE
     address owner;
    //MODIFIERS
    modifier onlyOwner() {
       require(msg.sender == owner,"Only the owner can update");
        _;
    }
     modifier onlyInvestor( address _key) {
         InvestorsProfile memory inv;
         inv.id = _key;
       require(msg.sender == _key,"Only an Investor can update");
        _;
    }
    //CONSTRUCTOR
    constructor () public {
        owner = msg.sender;
        roiRatio();
    }
//EVENTS
     event AddInvestor(address indexed owner, address indexed investor, string name);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event TransferToOutsiders(address indexed from, address indexed to, uint amount);
    // *** GETTER METHODS ***
   function getInvestor(address _key) internal pure returns(string memory) {
        InvestorsProfile memory inv;
       inv.id = _key;
        return inv.name;
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
 function addInvestor (address _newInvestorsAddress,string calldata _name) external onlyOwner returns(bool) {
 InvestorsProfile memory investorr;
       investorr.name = _name;
      investor[_newInvestorsAddress] = investorr;
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
    function returnOnInvestment( address investor,uint _investment) public view  onlyInvestor(investor) returns(uint){
      uint roi = (_investment / uint(10));
      return roi;
    }
    function transferToInvestor(address investor, uint _amount) external payable onlyOwner returns (bool) {
        require(balances[investor] <= balances[msg.sender],"There was an overflow");
        balances[msg.sender] = (balances[msg.sender] - (_amount));
        balances[investor] = (balances[investor] + (_amount));
        emit Transfer(msg.sender, investor, _amount);
        return true;
    }
    function transferToOutsiders(address sender,address outsideReceiver,uint _amount) external payable  returns (bool) {
        InvestorsProfile memory inv;
        inv.id = sender;
        require(msg.sender == sender,"Only an Investor can update");
        require(balances[outsideReceiver] <= balances[msg.sender],"There was an overflow");
        balances[msg.sender] = (balances[msg.sender] - (_amount));
        balances[outsideReceiver] = (balances[outsideReceiver] + (_amount));
        emit TransferToOutsiders(msg.sender, outsideReceiver, _amount);
        return true;
    }
    function addBalance(address holder, uint _balances) public view {
       (getBalanceOf(holder) + _balances);
    }

    // *** DELETE METHODS ***
    function deleteInvestor(address _investor) external  onlyOwner  {
        delete investor[_investor];
    }
     function deleteInvestment(address _investmentholder) external  onlyOwner  {
        delete storeInvestment[_investmentholder];
    }
    function deleteROI(address _roiHolder) external  onlyOwner  {
        delete storeROI[_roiHolder];
    }
 function deleteAddress(address _holder) public onlyOwner {
        delete storeAddress[_holder];
    }
    function deletebalances(address _balanceHolder) external  onlyOwner  {
        delete balances[_balanceHolder];
    }
}

