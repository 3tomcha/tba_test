import './App.css'
import { createWeb3Modal, defaultWagmiConfig } from '@web3modal/wagmi/react'
import { arbitrum, goerli } from 'wagmi/chains'

const projectId = '2bfeddcc836c3949daf198f82ac19134'

const metadata = {
  name: 'Web3Modal',
  description: 'Web3Modal Example',
  url: 'https://web3modal.com',
  icons: ['https://avatars.githubusercontent.com/u/37784886']
}

const chains = [goerli, arbitrum]
const wagmiConfig = defaultWagmiConfig({ chains, projectId, metadata })

createWeb3Modal({ wagmiConfig, projectId, chains })

export function ConnectButton() {
  return <w3m-button />
}

function App() {
  return (
    <>
      <ConnectButton />
    </>
  )
}

export default App
