// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './MyErc20.sol';
contract Faucet{
     mapping (address => bool) had;
     uint256 public amountAllowed = 10;
     address public tokenAddress;
     constructor(address _tokenContract) {
        tokenAddress = _tokenContract;
     }
     function applyToken() public  {
        require(!had[msg.sender], "Can't Request Multiple Times!");
        Token t = Token(tokenAddress);
        uint balance = t.balanceOf(address(this));
        require(balance >= amountAllowed);
        t.transfer(msg.sender, amountAllowed); // 发送token
        had[msg.sender] = true;
     }
}
