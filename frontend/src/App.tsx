import './App.css'
import { createWeb3Modal, defaultWagmiConfig } from '@web3modal/wagmi/react'
import { arbitrum, goerli } from 'wagmi/chains'
import ExampleERC6551AccountAbi from "./abi/ExampleERC6551Account.abi";
import { createPublicClient, http } from 'viem'

const projectId = '2bfeddcc836c3949daf198f82ac19134'

const metadata = {
  name: 'Web3Modal',
  description: 'Web3Modal Example',
  url: 'https://web3modal.com',
  icons: ['https://avatars.githubusercontent.com/u/37784886']
}

const chains = [goerli, arbitrum]
const wagmiConfig = defaultWagmiConfig({ chains, projectId, metadata })

export const publicClient = createPublicClient({
  chain: goerli,
  transport: http()
})

createWeb3Modal({ wagmiConfig, projectId, chains })

const getBalance = async () => {
  const balance = await publicClient.getBalance({
    address: "0x5a10d152072832823c38e964E382CD22C00a8d7E",
  })
  alert(balance)
}
export function ConnectButton() {
  return <w3m-button />
}

function App() {
  return (
    <>
      <ConnectButton />
      <button onClick={getBalance}>getBalance</button>
    </>
  )
}

export default App
