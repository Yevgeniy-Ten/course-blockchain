// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Note {
    //Мы можем писать заметки а также читать наши заметки
    string myNote; //state variable (состояние переменная)
    // external - можно вызвать извне контракта (в другом контракте)
    //модификаторы доступа: private, internal, extarnal, public
    //Если public -> автоматический создается геттер функция
    event NoteSet(address from,string note);
    //reference type (ссылочных типов) локальных переменных пишем memory
    function setNote(string memory _note) public {
        myNote = _note;
        emit NoteSet(msg.sender, _note);
        // emit - вызывает событие это тип лог
    }

    function getNote() public view returns (string memory) {//view = gasless (бесплатной)
        return myNote;
    }

// view - не изменяет состояние контракта, не изменяет state variable,
// pure - не изменяет состояние контракта, не изменяет state variable, не читает state variable
//    view локальное чтение , pure не локально
    function pureNote(string memory _pureNote) public pure returns (string memory){//pure вы даже не читаете state
        return _pureNote;
    }

}
