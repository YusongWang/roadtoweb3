// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "./Staker.sol";

contract ExampleExternalContract {

  address payable owner;
  bool public completed;

  event SendToOwner(
    address owner,
    uint256 amount
  );

  modifier onlyOwner() {
    require(msg.sender == owner,"can't call without owner");
    _;
  }

  constructor() {
    owner = payable(msg.sender);
  }

  function complete() public payable {
    completed = true;
  }

  function sendToOwner() public onlyOwner payable{
      owner.transfer(address(this).balance);
  }
}
