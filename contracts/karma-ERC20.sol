// Copyright [2021] - [2021], [Shaun Reed] and [Karma] contributors
// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0;

// ----------------------------------------------------------------------------
// Import ERC Token Standard #20 Interface
//   ETH EIP repo: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// ----------------------------------------------------------------------------
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

// ----------------------------------------------------------------------------
// Karma Contract
// ----------------------------------------------------------------------------
contract Karma is IERC20, Initializable
{
    // Avoid initializing fields in declarations
    // https://docs.openzeppelin.com/upgrades-plugins/1.x/writing-upgradeable#avoid-initial-values-in-field-declarations
    string public name;
    string public symbol;
    uint8 public decimals; // 18 decimals is the strongly suggested default, avoid changing it
    uint256 public _totalSupply;

    // Balances for each account; A hashmap using wallet address as key and uint as value
    mapping(address => uint) balances;
    
    // Owner of account approves the transfer of an amount to another account
    mapping(address => mapping(address => uint)) allowed;
//
//    /**
//     * Constrctor function
//     *
//     * Initializes contract with initial supply tokens to the creator of the contract
//     */
//    constructor()
//    {
//        name = "Karma";    // Name of the token
//        symbol = "KRMA";         // Abbreviation of the token
//        decimals = 18;          // Number of decimals that can be used to split token
//
//
//        // FORMAT: <SUPPLY><DECIMALS>
//        // Where SUPPLY is the number of coins in base 10 decimal notation
//        // And DECIMALS is a trailing number of 0's; Count must match `decimals` value set above
//        // 1000 000 000 000000000000000000 == 1 billion total supply;
//        //  + trailing 0's represent the 18 decimal locations that can be used to send fractions
//        _totalSupply = 1000000000000000000000000000;
//
//
//        // Set the remaining balance of the contract owner to the total supply
//        balances[msg.sender] = _totalSupply; // msg.sender is the calling address for this constructor
//        // Transfer the total supply to the contract owner on initialization
//        emit Transfer(address(0), msg.sender, _totalSupply); // address(0) is used to represent a new TX
//    }

    function initialize() public initializer
    {
        // ERC20 Standard dictates names of these variables
        // https://ethereum.org/en/developers/docs/standards/tokens/erc-20/#body
        name = "Karma";    // Name of the token
        symbol = "KRMA";         // Abbreviation of the token
        decimals = 18;          // Number of decimals that can be used to split token


        // FORMAT: <SUPPLY><DECIMALS>
        // Where SUPPLY is the number of coins in base 10 decimal notation
        // And DECIMALS is a trailing number of 0's; Count must match `decimals` value set above
        // 1000 000 000 000000000000000000 == 1 billion total supply;
        //  + trailing 0's represent the 18 decimal locations that can be used to send fractions
        _totalSupply = 1000000000000000000000000000;


        // Set the remaining balance of the contract owner to the total supply
        balances[msg.sender] = _totalSupply; // msg.sender is the calling address for this constructor
        // Transfer the total supply to the contract owner on initialization
        emit Transfer(address(0), msg.sender, _totalSupply); // address(0) is used to represent a new TX
    }


    // Get the total circulating supply of the token 
    function totalSupply() public override view returns (uint)
    {
        // By subtracting from tokens held at address(0), we provide an address to 'burn' the supply
        return _totalSupply - balances[address(0)]; // Subtract from tokens held at address(0)
    }

    // Get the token balance for account `tokenOwner`
    function balanceOf(address tokenOwner) public override view returns (uint balance)
    {
        return balances[tokenOwner]; // Return the balance of the owner's address
    }

    // To initiate a transaction, we first approve an address to withdraw from our wallet
    //  + msg.sender is approving spender to withdraw from its balance _value tokens
    // Allow `spender` to withdraw from your account, multiple times, up to the `tokens`
    // If this function is called again it overwrites the current allowance with _value
    function approve(address spender, uint _value) public override returns (bool success)
    {
        //  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
        //if ((value != 0) && (allowed[msg.sender][spender] != 0)) throw;

        allowed[msg.sender][spender] = _value;
        emit Approval(msg.sender, spender, _value);
        return true;
    }

    // Helper to check the amount of tokens allowed for this spender at this address
    // @param tokenOwner The address of the account owning tokens
    // @param spender The address of the account able to transfer the tokens
    // returns Amount of remaining tokens allowed to spent
    function allowance(address tokenOwner, address spender) public override view returns (uint remaining)
    {
        return allowed[tokenOwner][spender];
    }

    // Send `_value` amount of tokens from address `from` to address `to`
    function transferFrom(address from, address to, uint _value) public override returns (bool success)
    {
        // Set this wallet balance -= _value
        balances[from] = balances[from] - _value;

        // Update this wallet's approved balance for the withdrawing address
//        uint allowance = allowed[from][msg.sender];
        allowed[from][msg.sender] -= _value;

        // Add the amount of tokens to the balance at the receiving address
        balances[to] = balances[to] + _value;
        emit Transfer(from, to, _value);
        return true;
    }

    // Transfer the balance from owner's account to another account
    function transfer(address to, uint tokens) public override returns (bool success)
    {
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

}
