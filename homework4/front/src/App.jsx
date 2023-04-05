import {useEffect, useState} from 'react'
import {Contract, ethers} from "ethers";
import {CONTRACT_ABI, NFT_ADDRESS} from "./constants/index.js";
import {getProvider} from "./utils/lib.js";


function App() {
    const [provider, setProvider] = useState(null);
    const [account, setAccount] = useState(null);
    const [contract, setContract] = useState(null);
    const [networkId, setNetworkId] = useState(null);
    const connect = ()=>{
        const init = async () => {
            const provider = await getProvider();

            const network = await provider.getNetwork();
            if (network.chainId !== 97) {
                alert("Please connect to BSC Testnet")
                return;
            }
            const signer = provider.getSigner()
            const nftContract = new ethers.Contract(NFT_ADDRESS, CONTRACT_ABI, signer);
            const currentAccount = await signer.getAddress();

            setProvider(provider);
            setAccount(currentAccount);
            setContract(nftContract);
            setNetworkId(network.chainId);
        };
        if (window.ethereum) {
            init();
        }
    }
    useEffect(() => {
        connect();
    }, [])
    const handleMint = async () => {
        try{
            const tx = await contract.safeMint(account,{
                value: ethers.utils.parseEther("0.00001")
            });
            await tx.wait();
            alert("Minted successfully");
        }catch (e) {
            alert("Mint failed");
        }
    };
    return (
        <div className={"min-h-screen flex items-center justify-center"}>
            <div
                className="bg-blue-500 rounded-full h-16 max-w-sm w-full text-white flex items-center justify-center cursor-pointer">
                {provider ? (
                    <>
                        <div className="flex flex-col items-center mr-2">
                            <p className="font-bold">{account.slice(0, 6) + "..." + account.slice(-4)}</p>
                            <p className="text-xs">Connected</p>
                        </div>
                        <button
                            className="bg-white hover:bg-gray-200 text-blue-500 font-bold py-2 px-4 rounded-full"
                            onClick={handleMint}
                        >
                            Mint NFT
                        </button>
                    </>
                ):
                    <button
                        className="bg-white hover:bg-gray-200 text-blue-500 font-bold py-2 px-4 rounded-full"
                        onClick={connect}
                    >
                        Connect NFT
                    </button>
                }
            </div>
        </div>
    )
}

export default App
