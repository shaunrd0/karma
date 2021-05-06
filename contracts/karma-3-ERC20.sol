// Copyright [2021] - [2021], [Shaun Reed] and [Karma] contributors
// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

// ----------------------------------------------------------------------------
// Import ERC Token Standard #20 Interface
//   ETH EIP repo: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// ----------------------------------------------------------------------------
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

// ----------------------------------------------------------------------------
// Karma Contract
// ----------------------------------------------------------------------------

contract KarmaV3 is Initializable, ERC20Upgradeable
{
    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(_msgSender(), initialSupply);
    }

    function isToken() public pure returns (bool)
    {
        return true;
    }

    function getAddress() public view returns (address)
    {
        return address(this);
    }

}
