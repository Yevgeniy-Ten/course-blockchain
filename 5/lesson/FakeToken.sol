pragma solidity ^0.8.0;

contract FakeToken {
//    public это модификатор доступа, который позволяет читать значение переменной извне
//    при public автоматически создается геттер, который позволяет получить значение переменной
    string public name = "Fake Token";
    string public symbol = "FTKN";
    uint256 totalSupply;
    mapping(address => uint256) balanceOf;
    mapping(address => mapping(address => uint256)) allowances;
// memory  это ключевое слово, которое указывает, что переменная будет храниться в памяти, а не в хранилище
    constructor(string memory _name,string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

// require это проверка, которая прерывает выполнение функции, если условие не выполняется, есть еще assert, который прерывает выполнение в любом случае на примере:
// assert(1 == 2); // прерывает выполнение
// require(1 == 2); // прерывает выполнение
// require(1 == 1); // продолжает выполнение
// assert(1 == 1); // продолжает выполнение
// разница в том, что assert используется для проверки внутренних ошибок, а require для проверки внешних данных, которые приходят в функцию (например, от пользователя)
// есть еще revert, который прерывает выполнение и возвращает сообщение об ошибке,  откатывает транзакцию
    function transfer(address to, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Not enough tokens");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
    }
//    internal это модификатор доступа, который позволяет вызывать функцию только внутри контракта
    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
    }

    function transferFrom(address _from,address _to, uint256 _amount ) public{
        require(balanceOf[_from]>_amount);
        require(balanceOf[_from][_to]>=_amount);
        balanceOf[_from] -= _amount;
        balance[_to] +=_amount;
        allowances[_from][_to] -=_amount;
    }


    function approve(address _to, uint256 _amount) public  {
        allowances[msg.sender][_to] -=_amount;
    }

}
