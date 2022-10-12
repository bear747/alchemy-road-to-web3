// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// import Ownable library to access transferOwnership function
import "@openzeppelin/contracts/access/Ownable.sol";

// deployed to Goerli at 0x25E1CeE7A553b023C8a73EaFCC0428940ba189dD

contract BuyMeACoffee is Ownable{
    // event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // list of all memos received from friends
    Memo[] memos;

    // address of contract deployer
    address payable originalOwner;

    // address of new owner that we'll transfer ownership to
    //address payable newOwner = payable(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

    // deploy logic
    constructor() {
        originalOwner = payable(msg.sender);
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the coffee buyer
     */

    // tom's edited function to make payment amount flexible
     function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth"); // revert if no money sent!

        // add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
     }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
     function withdrawTips() public{
        address(this).balance;
        require(originalOwner.send(address(this).balance));
     }

     /**
     * @dev allow the owner withdraw tips to an alternative address
     */
     function withdrawTipsAlternativeAddress() public {
        address payable alternativeAddress = payable(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        address(this).balance;
        bool sent = alternativeAddress.send(address(this).balance);
        require(sent, "Failure - not sent");
     }
    
    /**
    * @dev transfer ownership of the contract to a new owner (current owner only) (openzepplin attempt)
    */
    function transferToNewOwner() public {
        address payable newOwner = payable(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        transferOwnership(newOwner); // initiates the ownership transfer in metamask
        originalOwner = newOwner; // set originalOwner to newOwner so that withdrawTips function withdraws to newOwner
    }

    /**
     * @dev retrieve all the memos received and stored on the blockchain
     */
     function getMemos() public view returns(Memo[] memory) {
        return memos;
     }

    /**
    * @dev attempted to write my own transferOwnership function.  It doesn't work so I gave up and imported from openzepplin.
    */
    // function transferOwnership() public{
    //     require(owner == msg.sender, "not the owner");
    //     address payable newOwner = payable(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    //     owner = newOwner;
    // }

}
