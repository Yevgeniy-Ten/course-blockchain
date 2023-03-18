// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlipper {
    constructor() payable {

    }
    event GamePlayed(address player,bool);
    function playGame(uint8 _option) payable public returns (bool) {
        uint256 _output = block.timestamp % 2;
        require(_option<=1,"you can choose 0 or 1");
        require(address(this).balance >=msg.value *2,"SMART CONTRACT");
        emit GamePlayed(msg.sender,true);
        if(_option ==_output){
            payable(msg.sender).transfer(msg.value * 2);
            return true;
        }
        return false;
    }

// функция receive это функция которая вызывается когда мы отправляем эфир на контракт без вызова функции,  т.е. просто отправляем эфир
    receive () external payable{

    }
}
