// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



contract SignedDoc{
    struct Signer{
        address signer;
        uint256 timestamp;
        bool signed;
    }
    string[] public docNames;
    mapping (string => Signer[]) signersDocs;
    event DocSigned(address owner, string name, uint256 timestamp);
    event Signers(address[] signers);

    function getDocNames() public view returns(string[] memory){
        return docNames;
    }
    function createDoc(string memory _docName, address[] memory shouldSigners) public {
        emit Signers(shouldSigners);
        require(shouldSigners.length > 0, "signers require");
        if(signersDocs[_docName].length > 0){
            revert("Document already exists");
        }
        for(uint i = 0; i < shouldSigners.length; i++){
            signersDocs[_docName].push(Signer({
            signer:shouldSigners[i],
            timestamp:0,
            signed:false
            }));
            docNames.push(_docName);
        }
    }
    function getDocSigners(string memory _docName) public view returns(Signer[] memory){
        Signer[] storage signers = signersDocs[_docName];
        require(signers.length > 0, "Document not exists");
        return signers;
    }
    function allSigned(string memory _docName) public view returns(bool){
        Signer[] storage signers = signersDocs[_docName];
        require(signers.length > 0, "Document not exists");
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
        require(signers.length > 0, "Document not exists");

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
