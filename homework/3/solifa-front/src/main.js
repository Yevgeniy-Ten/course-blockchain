import {ethers, parseUnits} from "ethers";

const contractToken = '0x37a54a272def35f3fb621c20980af18d69a678ed'
const abi = [
  {
    "inputs": [],
    "stateMutability": "payable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "player",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "enum Solifa.Status",
        "name": "_input",
        "type": "uint8"
      },
      {
        "indexed": false,
        "internalType": "enum Solifa.Status",
        "name": "_innerInput",
        "type": "uint8"
      }
    ],
    "name": "GameEmit",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "getResult",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "enum Solifa.Status",
        "name": "_option",
        "type": "uint8"
      }
    ],
    "name": "playGame",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "stateMutability": "payable",
    "type": "receive"
  }
]

const {Contract} = ethers

let contract

function connectMetaMask() {
  if (!window.ethereum) {
    return 'Metamask not installed'
  }
  const provider = new ethers.BrowserProvider(window.ethereum, 97)
  provider.send('eth_requestAccounts', [])
    .then(() => provider.listAccounts())
    .then(accounts => {
      console.log(accounts)
      return provider.getSigner(accounts[0].address)
    })
    .then(signer => {
      contract = new Contract(contractToken, abi, signer)
    })
}

function playGameHandler(number) {
  const amount = prompt('Введите сумму на которое хотите сыграть (GWEI):')
  contract.playGame(parseInt(number), {
    value: parseUnits(amount, 'gwei')
  })
    .then(response => {
      console.log(response)
      contract.getResult().then(result=>{
        console.log(typeof result)
        switch (result) {
          case '0n':
            alert("YOU FAIL")
          case '1n':
            alert("DRAW")
          case '2n':
            alert("YOU WIN")
        }
      })
    })
    .catch(e => {
      alert(e.reason)
    })
}


document.addEventListener('DOMContentLoaded', function () {
  connectMetaMask()
  const sulifaSelect = document.getElementById('SulifaValue')
  const playGameButton = document.getElementById('PlayGameButton')
  playGameButton.addEventListener('click', e => {
    playGameHandler(sulifaSelect.value)
  })
});

