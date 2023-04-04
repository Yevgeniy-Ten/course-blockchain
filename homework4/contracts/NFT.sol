// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";


contract NFT is ERC721Enumerable, Ownable {
    using Strings for uint256; //-> для конвертации uint в string

    uint maxSupply = 10; //-> максимальное количество токенов

    uint cost = 0.00001 ether; //-> стоимость токена
    string baseURI = "ipfs://QmVUqhLBjfZrtBCZaufNSH4o3e2LqHhXUHwsJGwzTAKz5p/"; //-> базовый URI для токена
// первый аргумент это имя токена, второй это сокращенное имя токена
    constructor() ERC721("CAT_NFT", "CAT") {}
//    функция mint для создания токена с указанием адреса и id токена, она вызывает функцию _mint из библиотеки openzeppelin которая создает токен tokenid это id токена, to это адрес владельца токена
    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
    function tokenURI(
        uint256 tokenId // virtual означает что функция может быть переопределена в дочернем контракте
    ) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        return bytes(baseURI).length > 0
        ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
        : "";
    }


    function changeBaseURI(string memory newBaseURI) public onlyOwner {
        baseURI = newBaseURI;
    }
//эта функция проверяет существует ли токен с указанным id, то есть при вызове safeMint, если токен с таким id уже существует, то функция не будет выполнена
    function safeMint(address _to) public payable {
        uint256 _currentSupply = totalSupply();
        require(_currentSupply < maxSupply, "You reached max supply");
        require(msg.value == cost, "Please add valid amount of ETH");
        _safeMint(_to, _currentSupply);
    }
    function withdraw() public onlyOwner {
        //
        (bool success, ) = payable(msg.sender).call{
                value: address(this).balance
            }("");
        require(success);
    }
}
