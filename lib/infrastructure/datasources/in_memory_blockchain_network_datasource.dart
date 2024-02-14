// // ignore_for_file: avoid_print

// import 'package:tradex_wallet_3/domain/datasources/blockchain_network_datasource.dart';
// import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';

// class InMemoryBlockchainNetworkDatasource extends BlockchainNetworkDatasource {
//   @override
//   Future<List<BlockchainNetwork>> getBlockchainNetworks() async {
//     List<BlockchainNetwork> blockchainNetworks = [
//       BlockchainNetwork(
//         id: 0,
//         identity: BlockchainIdentity.solana,
//         name: 'Solana',
//         iconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png?v=025',
//         websiteUrl: 'https://solana.com',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 1,
//         identity: BlockchainIdentity.bnb,
//         // name: 'Binance Smart Chain',
//         name: 'Binance',
//         iconUrl: 'https://cryptologos.cc/logos/bnb-bnb-logo.png?v=025',
//         websiteUrl: 'https://www.binance.org/en/smartChain',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 2,
//         identity: BlockchainIdentity.bitcoin,
//         name: 'Bitcoin',
//         iconUrl: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=025',
//         websiteUrl: 'https://bitcoin.org',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 3,
//         identity: BlockchainIdentity.tron,
//         name: 'Tron',
//         iconUrl: 'https://cryptologos.cc/logos/tron-trx-logo.png?v=025',
//         websiteUrl: 'https://tron.network',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 4,
//         identity: BlockchainIdentity.polygon,
//         name: 'Polygon',
//         iconUrl: 'https://cryptologos.cc/logos/polygon-matic-logo.png?v=025',
//         websiteUrl: 'https://polygon.technology',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 5,
//         identity: BlockchainIdentity.ethereum,
//         name: 'Ethereum',
//         iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
//         websiteUrl: 'https://ethereum.org',
//         nodeUrl: '',
//       ),
//       BlockchainNetwork(
//         id: 6,
//         identity: BlockchainIdentity.sepolia,
//         name: 'Sepolia',
//         iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
//         websiteUrl: 'https://ethereum.org',
//         nodeUrl:
//             'https://sepolia.infura.io/v3/cb45c20c58184e209174b90e87ba49b2',
//       ),
//       BlockchainNetwork(
//         id: 7,
//         identity: BlockchainIdentity.goerli,
//         name: 'Goerli',
//         iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
//         websiteUrl: 'https://ethereum.org',
//         nodeUrl: 'https://goerli.infura.io/v3/e04c95472ca8475e9d352ef258a2e556',
//       ),
//     ];

//     return blockchainNetworks;
//   }

//   @override
//   Future<BlockchainNetwork> getCurrentNetwork() {
//     // ToDo: implement getCurrentNetwork
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setCurrentNetwork(BlockchainNetwork network) {
//     // ToDo: implement setCurrentNetwork

//     throw UnimplementedError();
//   }
// }
