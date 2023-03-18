// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20{
    constructor() ERC("Token", "TKN") {
        _mint(msg.sender, 100 * 10 ** 18);
    }
}
