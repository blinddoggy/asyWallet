import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
// import 'package:tradex_wallet_3/storage/infrastructure/datasources/isar_local_storage_datasource.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/repositories/local_storage_repository_impl.dart';

class BlockchainNetworkUseCases {
  final LocalStorageDatasource<BlockchainNetwork> localStorageDatasource;
  final LocalStorageRepository<BlockchainNetwork> localStorageRepository;
  BlockchainNetworkUseCases(this.localStorageDatasource)
      : localStorageRepository =
            LocalStorageRepositoryImpl(localStorageDatasource);
  Future<List<BlockchainNetwork>> getBlockhainNetwork() async {
    final blockchainNetworks = await localStorageRepository.getAll();
    return blockchainNetworks;
  }
}



// final blockchainNetworkLocalStorageDatasourceProvider =
//     Provider<LocalStorageDatasource<BlockchainNetwork>>(
//         (ref) => IsarLocalStorageDatasource(BlockchainNetworkSchema));

// final blockchainNetworkLocalStorageRepositoryProvider =
//     Provider<LocalStorageRepository<BlockchainNetwork>>((ref) {
//   final LocalStorageDatasource<BlockchainNetwork> localStorageDatasource =
//       ref.watch(blockchainNetworkLocalStorageDatasourceProvider);

//   final LocalStorageRepository<BlockchainNetwork> localStorageRepository =
//       LocalStorageRepositoryImpl(localStorageDatasource);

//   return localStorageRepository;
// });
