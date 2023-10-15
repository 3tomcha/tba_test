import './App.css'
import { createWeb3Modal, defaultWagmiConfig } from '@web3modal/wagmi/react'
import { arbitrum, localhost } from 'wagmi/chains'
import { ExampleERC6551AccountAbi } from "./abi/ExampleERC6551Account.abi";
import { createPublicClient, http, custom } from 'viem'
import { getContract } from '@wagmi/core';

const projectId = '2bfeddcc836c3949daf198f82ac19134'
const accountAddress = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0"

const metadata = {
  name: 'Web3Modal',
  description: 'Web3Modal Example',
  url: 'https://web3modal.com',
  icons: ['https://avatars.githubusercontent.com/u/37784886']
}

const chains = [localhost, arbitrum]
const wagmiConfig = defaultWagmiConfig({ chains, projectId, metadata })

export const publicClient = createPublicClient({
  chain: localhost,
  transport: http()
})

export const walletClient = createPublicClient({
  chain: localhost,
  transport: custom(window.ethereum)
})

const account = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
const account2 = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8"

createWeb3Modal({ wagmiConfig, projectId, chains })

const getBalance = async () => {
  const balance = await publicClient.getBalance({
    address: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
  })
  alert(balance)
}

const getContract_ = async () => {
  const { request } = await publicClient.simulateContract({
    address: '0xFBA3912Ca04dd458c843e2EE08967fC04f3579c2',
    abi: ExampleERC6551AccountAbi,
    functionName: 'execute',
    args: [account2, 1000, " ", 1],
    account
  })
  await walletClient.writeContract(request);
}

export function ConnectButton() {
  return <w3m-button />
}

function App() {
  return (
    <>
      <ConnectButton />
      <button onClick={getBalance}>getBalance</button>
      <button onClick={getContract_}>getContract_</button>
    </>
  )
}

export default App
