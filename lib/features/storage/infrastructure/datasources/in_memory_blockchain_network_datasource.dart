import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';

class InMemoryBlockchainNetworkDatasource
    extends LocalStorageDatasource<BlockchainNetwork> {
  // @override
  Future<List<BlockchainNetwork>> getBlockchainNetworks() async {
    List<BlockchainNetwork> blockchainNetworks = [
      BlockchainNetwork(
        id: 0,
        identity: BlockchainIdentity.tron,
        name: 'Tron',
        iconUrl: 'https://cryptologos.cc/logos/tron-trx-logo.png?v=025',
        contractAddress: '',
        websiteUrl: 'https://tron.network',
        nodeUrl: '',
        nativeCurrency: 'TRON',
        decimals: 0,
      ),
      // BlockchainNetwork(
      //   id: 7,
      //   identity: BlockchainIdentity.goerli,
      //   name: 'Goerli',
      //   iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
      //   contractAddress: '',
      //   websiteUrl: 'https://ethereum.org',
      //   nodeUrl: 'https://goerli.infura.io/v3/e04c95472ca8475e9d352ef258a2e556',
      //   nativeCurrency: 'GETH',
      //   decimals: 18,
      // ),
      // BlockchainNetwork(
      //   id: 6,
      //   identity: BlockchainIdentity.mumbai,
      //   name: 'Mumbai',
      //   iconUrl: 'https://cryptologos.cc/logos/polygon-matic-logo.png?v=025',
      //   websiteUrl: 'https://polygon.technology',
      //   nodeUrl:
      //       'https://polygon-mumbai.infura.io/v3/a3f23ab5e9ad4d9a941a1231918cb2fa',
      //   nativeCurrency: 'MATIC',
      //   decimals: 18,
      //   contractAddress: '',
      // ),
      // BlockchainNetwork(
      //   id: 0,
      //   identity: BlockchainIdentity.solana,
      //   name: 'Solana',
      //   iconUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png?v=025',
      //   contractAddress: '',
      //   websiteUrl: 'https://solana.com',
      //   nodeUrl: '',
      //   nativeCurrency: 'SOL',
      // ),
      BlockchainNetwork(
        id: 1,
        identity: BlockchainIdentity.bnb,
        name: 'BNB',
        contractAddress: '',
        iconUrl: 'https://cryptologos.cc/logos/bnb-bnb-logo.png?v=025',
        websiteUrl: 'https://www.binance.org/en/smartChain',
        nodeUrl: 'https://binance.nodereal.io/',
        nativeCurrency: 'BNB',
        decimals: 18,
      ),
      // BlockchainNetwork(
      //   id: 2,
      //   identity: BlockchainIdentity.bitcoin,
      //   name: 'Bitcoin',
      //   iconUrl: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=025',
      //   contractAddress: '',
      //   websiteUrl: 'https://bitcoin.org',
      //   nodeUrl: '',
      //   nativeCurrency: 'BTC',
      // ),
      BlockchainNetwork(
        id: 4,
        identity: BlockchainIdentity.polygon,
        name: 'Polygon',
        iconUrl: 'https://cryptologos.cc/logos/polygon-matic-logo.png?v=025',
        contractAddress: '',
        websiteUrl: 'https://polygon.technology',
        nodeUrl:
            'https://polygon-mainnet.infura.io/v3/cb45c20c58184e209174b90e87ba49b2',
        nativeCurrency: 'MATIC',
        decimals: 18,
      ),
      BlockchainNetwork(
        id: 5,
        identity: BlockchainIdentity.ethereum,
        name: 'Ethereum',
        iconUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
        contractAddress: '',
        websiteUrl: 'https://ethereum.org',
        nodeUrl:
            'https://mainnet.infura.io/v3/cb45c20c58184e209174b90e87ba49b2',
        nativeCurrency: 'ETH',
        decimals: 18,
      ),
    ];

    return blockchainNetworks;
  }

  @override
  Future<List<BlockchainNetwork>> getAll({int limit = 10, int offset = 0}) {
    return getBlockchainNetworks();
  }

  @override
  Future<BlockchainNetwork?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> save(AbstractCollectibleEntity entity) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<int>> saveAll(List<BlockchainNetwork> entities) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }
}
