import Web3Modal from "web3modal";
import {ethers} from "ethers";

export const web3Modal = new Web3Modal({
    network: 97,
    providerOptions: {},
    disableInjectedProvider: false,
})
export const getProvider = async () => {
    const web3Provider = await web3Modal.connect()
    const provider = new ethers.providers.Web3Provider(web3Provider)
    return provider
}
