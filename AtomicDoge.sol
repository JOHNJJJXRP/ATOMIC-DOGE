pragma solidity ^0.8.2;

contract AtomicDoge {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 10000  * 10 ** 18;
    string public name = "AtomicDoge";
    string public symbol ="ATD";
    uint public decimals = 18;
    event Transfer(address  from, address indexed to, uint value);
    event Approval(address  owner, address indexed spender, uint value);

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }

    //... This function tranfers one token to another address
    
    function tranfer(address to, uint value) public returns (bool){
        require(balanceOf(msg.sender)) >= value; "balance too low";
        balances[to] += value;
        balances[msg.sender] -= value;
        emit tranfer(msg.sender, to, value);
        return true;
    }
    function approve(address spender, uint value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    //..function of the delegated tranfer
    
        function transferFrom(address from, address to, uint value) public returns(bool) {
            require(balanceOf(from) >= value, "balance too low");
            require(allowance[from][msg.sender] >= value, "allowance too low");
            balances[to] += value;
            balances[from] -= value;
            emit Transfer(from, to, value);
            return true;
        }
    }


