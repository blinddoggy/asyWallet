import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';

abstract class BlockchainNetworkDatasource {
  Future<List<BlockchainNetwork>> getBlockchainNetworks();
  Future<BlockchainNetwork> getCurrentNetwork();
  Future<void> setCurrentNetwork(BlockchainNetwork network);
}
