// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./MyErc20.sol";

contract AirDrop {
    function getSum(uint256[] calldata _arr) public pure returns (uint256 sum) {
        for (uint256 i = 0; i < _arr.length; i++) sum = sum + _arr[i];
    }

    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        // Check: The length of _addresses array should be equal to the length of _amounts array
        require(
            _addresses.length == _amounts.length,
            "Lengths of Addresses and Amounts NOT EQUAL"
        );
        Token token = Token(_token); // Declare IERC contract variable
        uint256 _amountSum = getSum(_amounts); // Calculate the total amount of airdropped tokens
        // Check: The authorized amount of tokens should be greater than or equal to the total amount of airdropped tokens
        require(
            token.allowance(msg.sender, address(this)) >= _amountSum,
            "Need Approve ERC20 token"
        );

        // for loop, use transferFrom function to send airdrops
        for (uint8 i; i < _addresses.length; i++) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }
}
