// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



contract SignedDoc{
    struct Signer{
        address signer;
        uint256 timestamp;
        bool signed;
    }

    mapping (string => Signer[]) signersDocs;
    event DocSigned(address owner, string name, uint256 timestamp);


    function createDoc(string memory _docName, address[] memory shouldSigners) public {
        require(shouldSigners.length == 0, "Document and signers exist");
//зависает
        for(uint i = 0; i < shouldSigners.length; i++){
            signersDocs[_docName].push(Signer(shouldSigners[i], 0, false));
        }
    }

    function allSigned(string memory _docName) public view returns(bool){
        Signer[] storage signers = signersDocs[_docName];
        require(signers.length > 0, "Document and signers don't exist");
        for(uint i = 0; i < signers.length; i++){
            if(!signers[i].signed){
                return false;
            }
        }
        return true;
    }
//    calldata  это указатель на данные в памяти, которые не могут быть изменены
    function signDoc(string memory _docName ) public {
        Signer[] storage signers = signersDocs[_docName];

        for(uint i = 0; i < signers.length; i++){
            if(signers[i].signer == msg.sender){
                if(signers[i].signed){
                    // это означает, что подпись уже была и revert - отмена транзакции
                    revert("Already signed");
                }
                signers[i].timestamp = block.timestamp;
                signers[i].signed = true;
                emit DocSigned(msg.sender, _docName, block.timestamp);
            }
        }
    }
}
