import { ConnectWallet } from './components/ConnectWallet'

export default function Home() {
  return (
    <main className="min-h-screen p-8">
      <div className="max-w-7xl mx-auto">
        <header className="flex justify-between items-center mb-12">
          <h1 className="text-4xl font-bold">IdentityVault</h1>
          <ConnectWallet />
        </header>
        
        <section className="text-center py-20">
          <h2 className="text-5xl font-bold mb-4">Confidential Identity Management Platform</h2>
          <p className="text-xl text-gray-600 mb-8">
            Private and secure identity management powered by Zama FHEVM
          </p>
          <p className="text-gray-500">
            Website generation in progress...
          </p>
        </section>
      </div>
    </main>
  )
}

