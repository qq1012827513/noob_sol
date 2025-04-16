// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { ez_lib } from './all_in_one.sol';

library ez_lib{
    function add(uint a, uint b) external  pure returns (uint) {
        return a+b;
    }
}

interface EmptyInterface{
    function emptyFunction(uint) external returns(uint);
}
abstract contract EmptyAbstract{
    function emptyAbstractFunction(uint) external virtual returns(uint);
    function emptyAbstractFunctionNotVirtual(uint) public pure {}
}

contract all_in_one is EmptyInterface,EmptyAbstract{
    address owner;
    mapping (uint => uint) kEqv;
    event log(string indexed str, uint num);
    event receiveValue(uint value);

    error useError(string errMsg);

    constructor() {
        emit log("log: constructor", 0);
        for(uint i = 0; i < 10; i++) {
            kEqv[i] = i;
        }
        owner = msg.sender;
    }

    modifier ownerOnly () {
        require(msg.sender == owner, "you`re not owner");
        _;
    }

    function useLib(uint a, uint b) pure public returns(uint) {
        return ez_lib.add(a,b);
    }
    function useCall() public {
        (bool succ, bytes memory msg) = address(this).call{value: 10 gwei}("");
        emit log(string(msg), 0);
    }

    function usePayable() public payable {
        emit receiveValue(msg.value);
    }

    function useTrans() public payable  {
        bool ifSucc = payable(address(this)).send(10 gwei);
        if (!ifSucc) {
            revert useError("revert: send failed");
        }
        require(ifSucc, "require: send failed");
        emit log("log: send success", address(this).balance);
    }
    function useTry() external  {
        try this.getBanlance() {
            emit log("try: succ", 0);
        }catch Error(string memory msg){
            emit log(msg, 0);
        }
    }

    function emptyFunction(uint a) public pure returns(uint){
        return a;
    }

    function emptyAbstractFunction(uint c) override public returns(uint cc) {
        emit log("now it`s Not Virtual", 0);
        return c;
    }

    function getBanlance() public payable returns (uint256 balance) {
        balance = address(this).balance;
    }

    receive() external payable{
        emit log("function receive", msg.value);
    }

    fallback() external payable {
        emit log("function fallback", msg.value);
    }
}
contract all_in_one_child is all_in_one{

}