// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract NFTEventTickets {
    string public name = "NFT Event Ticket";
    string public symbol = "NFTT";
    uint256 public nextTokenId;
    uint256 public ticketPrice;
    address public owner;
    
    mapping(uint256 => address) public owners;
    mapping(address => uint256[]) public ticketsOwned;
    
    event TicketMinted(address indexed buyer, uint256 tokenId);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
    
    constructor(uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
    }
    
    function mintTicket() external payable {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        owners[nextTokenId] = msg.sender;
        ticketsOwned[msg.sender].push(nextTokenId);
        emit TicketMinted(msg.sender, nextTokenId);
        nextTokenId++;
    }
    
    function setTicketPrice(uint256 _newPrice) external onlyOwner {
        ticketPrice = _newPrice;
    }
    
    function getTicketsOwned(address _owner) external view returns (uint256[] memory) {
        return ticketsOwned[_owner];
    }
}


