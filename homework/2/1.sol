// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solifa {
    constructor() payable {}
    //1 BNB = 10^18 wei
    //1 bnb = 10^9 gwei
    //0.0001 bnb = 100000 gwei
    enum Status {
        STONE,
        SCISSORS,
        PAPER
    }
    // payable - можно отправить эфир на контракт
    event GameEmit(address player, Status _input, Status _innerInput);

    function playGame(Status _option) public payable returns (string memory) {
        require(msg.value >= 100000 gwei, "you need to send at least 0.0001 BNB");

        require(address(this).balance >= msg.value * 2, "SMART CONTRACT");

        uint256 _statusNum = block.timestamp % 3;
        Status _output = Status(_statusNum);
        emit GameEmit(msg.sender, _output, _option);


        if (_option == _output) {
            return "DRAW";
        }
        if (_option == Status.PAPER && _output == Status.PAPER) {
            return "FAIL";
        }
        // if (_option == 1 && _output == 0) {
        //     return "FAIL";
        // }
        // if (_option == 2 && _output == 1) {
        //     return "FAIL";
        // }
        payable(msg.sender).transfer(msg.value * 2);
        return "WIN";
    }

    receive() external payable {}
}
