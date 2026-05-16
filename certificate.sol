// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateVerifier {
    struct Certificate {
        string candidateName;
        string courseName;
        address recipient;
        uint256 dateOfIssuance;
        bool isValid;
    }

    address public authority;
    mapping(bytes32 => Certificate) private certificates;

    constructor() {
        authority = msg.sender;
    }

    function issueCertificate(
        string memory _id, 
        string memory _name, 
        string memory _course, 
        address _recipient
    ) public {
        require(msg.sender == authority, "Only authority can issue certificates");
        bytes32 idHash = keccak256(abi.encodePacked(_id));
        require(!certificates[idHash].isValid, "Certificate ID already exists");

        certificates[idHash] = Certificate({
            candidateName: _name,
            courseName: _course,
            recipient: _recipient,
            dateOfIssuance: block.timestamp,
            isValid: true
        });
    }

    function verifyCertificate(string memory _id) public view returns (
        string memory name, string memory course, address recipient, uint256 date, bool valid
    ) {
        bytes32 idHash = keccak256(abi.encodePacked(_id));
        Certificate memory cert = certificates[idHash];
        return (cert.candidateName, cert.courseName, cert.recipient, cert.dateOfIssuance, cert.isValid);
    }
}