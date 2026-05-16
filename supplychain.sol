// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    struct TrackLog {
        string status;
        uint256 timestamp;
        address handler;
    }

    struct Product {
        uint256 id;
        string name;
        TrackLog[] history;
    }

    mapping(uint256 => Product) private products;
    uint256 public productCount;

    function createProduct(string memory _name) public {
        productCount++;
        Product storage newProduct = products[productCount];
        newProduct.id = productCount;
        newProduct.name = _name;
        
        newProduct.history.push(TrackLog({
            status: "Manufactured",
            timestamp: block.timestamp,
            handler: msg.sender
        }));
    }

    function updateStatus(uint256 _productId, string memory _newStatus) public {
        require(_productId <= productCount && _productId > 0, "Product mismatch");
        
        products[_productId].history.push(TrackLog({
            status: _newStatus,
            timestamp: block.timestamp,
            handler: msg.sender
        }));
    }

    function getProductHistory(uint256 _productId) public view returns (TrackLog[] memory) {
        require(_productId <= productCount && _productId > 0, "Product mismatch");
        return products[_productId].history;
    }
}