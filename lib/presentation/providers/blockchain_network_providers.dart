import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';
// import 'package:tradex_wallet_3/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';

// todo: migrar estas funcionalidades hacia el account o la wallet...

// final blockchainNetworkStateNotifierProvider =
//     StateNotifierProvider<NetworkNotifier, BlockchainNetwork?>((ref) {
//   return NetworkNotifier(ref);
// });

// class NetworkNotifier extends StateNotifier<BlockchainNetwork?> {
//   // ignore: unused_field
//   final StateNotifierProviderRef _ref;
//   final LocalStorageRepository<BlockchainNetwork> _networkRepository;
//   NetworkNotifier(this._ref)
//       : _networkRepository =
//             _ref.watch(blockchainNetworkLocalStorageRepositoryProvider),
//         super(null) {
//     loadBlockchainNetwork();
//   }

//   Future<void> loadBlockchainNetwork() async {
//     _networkRepository.getAll().then((value) {
//       state = value.first;
//     });
//   }

//   Future<List<BlockchainNetwork>> getBlockchainNetworks() {
//     return _networkRepository.getAll();
//   }

//   void setBlockchainNetwork(BlockchainNetwork network) {
//     state = network;
//   }
// }

final blockchainNetworksProvider =
    FutureProvider<List<BlockchainNetwork>>((ref) async {
  final localstorage =
      ref.watch(blockchainNetworkLocalStorageRepositoryProvider);
  return await localstorage.getAll();
});
final currentBlockchainNetworkIdProvider = StateProvider((ref) => 0);
