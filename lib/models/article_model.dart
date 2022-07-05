class Article {
  String title;
  String content;
  Article({required this.title, required this.content});
}

List<Article> article = [
  Article(
    title: 'introduction',
    content:
        'Exploring the Web3 space on a mobile device can be intimidating for many, especially new users. For instance, not everyone understands how to utilize complicated DeFi tools like staking or lending.\n\nWhat is the difference between APY and APR? What staking options are there? What are the best rates? In addition, users typically need to track multiple addresses across different platforms to manage their assets, which can be a daunting task.\n\nFrontier aimsaspires to streamline the Web3 experience for everyone. With Frontier, crypto users can use one application to manage their digital assets, explore various DeFi protocols, and interact with popular Web3 applications without extensive knowledge of the space.',
  ),
  Article(
    title: 'native Integration',
    content:
        'Frontier natively integrates with crypto wallets, decentralized applications (dApps), and blockchain networks, both EVM and non-EVM compatible. Native integrations live directly inside the wallet, whereas non-native integrations rely on third-party applications or dApp browsers.\n\nThis allows users to interact with everything Web3 offers on one central interface. For example, users can easily connect and use their preferred mobile wallets, such as Trust Wallet or MetaMask, on the Frontier platform.\n\nNormally, users would have to switch between applications depending on their crypto assets and what network they want to explore., while Wwith Frontier, everything is available in one place. On the developer side, decentralized applications and partner protocols can use Frontier to access a wide range of users without needing to build a standalone application.',
  ),
  Article(
    title: 'blockchain Aggregator',
    content:
        'As a blockchain aggregator, Frontier allows users to interact with assets on different networks without switching applications. For instance, if you want to explore yield opportunities on Polygon, you can do it on the Frontier app instead of transferring your assets to another platform.\n\nAs of June 2022, Frontier supports more than 25 blockchain networks, including Ethereum and BNB Chain. Moreover, Frontier supports seven non-EVM compatible chains, including Solana, Tezos, Algorand, Zilliqa, Bluzelle, Elrond, and BNB Beacon Chain.\n\nFrontier also provides a chain-agnostic suite of tools for portfolio tracking and management. It allows users to stake crypto, provide liquidity, monitor open positions, and enter collateralized debt positions across multiple networks.',
  ),
];
