// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFT {
    string public name = "Digital Asset NFT";
    string public symbol = "DANFT";
    
    uint256 public nextTokenId;
    mapping(uint256 => address) public tokenOwner;
    mapping(uint256 => string) public tokenURIs; 

    function mint(string memory _metadataURI) public {
        uint256 currentId = nextTokenId;
        tokenOwner[currentId] = msg.sender;
        tokenURIs[currentId] = _metadataURI;
        nextTokenId++;
    }

    function transfer(address _to, uint256 _tokenId) public {
        require(tokenOwner[_tokenId] == msg.sender, "You do not own this token");
        require(_to != address(0), "Invalid recipient address");

        tokenOwner[_tokenId] = _to;
    }
}