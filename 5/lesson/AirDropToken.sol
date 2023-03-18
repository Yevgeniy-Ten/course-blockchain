pragma solidity ^0.8.0;


interface IFakeToken {
    //    external это модификатор доступа, который позволяет вызывать функцию только извне контракта, внутри контракта вызвать нельзя это нужно в interface
    function transfer(address to, uint256 amount) external;

    function transferFrom(address _from, address _to, uint256 _amount) external;
}

contract AirDropToken {

    function airdropWithTransfer(IFakeToken _token, address[] memory _addressArray, uint256[] memory _amountArray) public {
        _token.transfer(_addressArray[0], _amountArray[0]);
        // uint это тип данных, который хранит целое число, uint256 это тип данных, который хранит целое число, которое может быть от 0 до 2^256
        // uint8 это тип данных, который хранит целое число, которое может быть от 0 до 2^8
        // uint16 это тип данных, который хранит целое число, которое может быть от 0 до 2^16
        for (uint8 i = 0; i < _addressArray.length; i++) {
            _token.transfer(_addressArray[i], _amountArray[i]);
        }
    }
    // нужен allowence для  адресов
    function airdropWithTransferFrom(IFakeToken _token, address[] memory _addressArray, uint256[] memory _amountArray) public {
        _token.transfer(_addressArray[0], _amountArray[0]);
        // uint это тип данных, который хранит целое число, uint256 это тип данных, который хранит целое число, которое может быть от 0 до 2^256
        // uint8 это тип данных, который хранит целое число, которое может быть от 0 до 2^8
        // uint16 это тип данных, который хранит целое число, которое может быть от 0 до 2^16
        for (uint8 i = 0; i < _addressArray.length; i++) {
            _token.transferFrom(msg.sender,_addressArray[i], _amountArray[i]);
        }
    }
}
