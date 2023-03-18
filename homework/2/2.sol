// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



contract SignedDoc{
    struct Signer{
        address signer;
        uint256 timestamp;
        bool signed;
    }

    string docName;
    Signer[] signers;
    event DocSigned(address owner, string name, uint256 timestamp);


    function createDoc(string memory _docName, address[] memory shouldSigners) public {
        require(shouldSigners.length == 0, "Document and signers exist");
        for(uint i = 0; i < shouldSigners.length; i++){
            signers.push(Signer(shouldSigners[i], 0, false));
        }
        docName = _docName;
    }

    function allSigned() public view returns(bool){
        require(signers.length > 0, "No signers");
        for(uint i = 0; i < signers.length; i++){
            if(!signers[i].signed){
                return false;
            }
        }
        return true;
    }
    function signDoc() public {
        require(signers.length > 0, "No signers");
        for(uint i = 0; i < signers.length; i++){
            if(signers[i].signer == msg.sender){
                if(signers[i].signed){
                    // это означает, что подпись уже была и revert - отмена транзакции
                    revert("Already signed");
                }
                signers[i].timestamp = block.timestamp;
                signers[i].signed = true;
                emit DocSigned(msg.sender, docName, block.timestamp);
            }
        }
    }
}
