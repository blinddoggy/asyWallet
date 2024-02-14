// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tradex_wallet_3/infrastructure/datasources/in_memory_blockchain_network_datasource.dart';
// import 'package:tradex_wallet_3/infrastructure/repositories/blockchain_network_repository_impl.dart';

// final blockchainNetworkRepositoryProvider = Provider((ref) =>
//     BlockchainNetworkRepositoryImpl(InMemoryBlockchainNetworkDatasource()));

// final setBlockchainNetworkProvider = Provider((ref) async =>
//     ref.watch(blockchainNetworkRepositoryProvider).setCurrentNetwork());





// final selectNetworkUseCaseProvider = Provider.family<SelectNetworkUseCase, BlockchainNetwork>((ref, BlockchainNetwork network) {

  
//   // Aquí se podría inyectar el repositorio necesario para el caso de uso
//   // Por ejemplo: BlockchainNetworkRepository repository = BlockchainNetworkRepositoryImpl();
//   return SelectNetworkUseCase(network);
// });