pragma solidity >=0.4.22 <0.6.0;

contract ShareholdersDappStorage{
    mapping(address => InvestorsProfile) internal investor;
    mapping(address => uint) internal storeInvestment;
    mapping(address => uint) internal storeROI;
    mapping(address => bytes32) internal storeAddress;
    mapping(address => uint256) balances;

    struct InvestorsProfile{
        string name;
        uint investment;
        uint returnOnInvestment;
        address id;
        uint balance;

    }
 //bytes32[] __investors;
}