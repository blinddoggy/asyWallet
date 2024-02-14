import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/datasources/in_memory_blockchain_network_datasource.dart';

import 'package:tradex_wallet_3/features/storage/infrastructure/datasources/isar_local_storage_datasource.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/repositories/local_storage_repository_impl.dart';

final preferencesLocalStorageDatasourceProvider =
    Provider<LocalStorageDatasource<Preferences>>(
        (ref) => IsarLocalStorageDatasource<Preferences>());

final preferencesLocalStorageRepositoryProvider =
    Provider<LocalStorageRepository<Preferences>>((ref) {
  final LocalStorageDatasource<Preferences> localStorageDatasource =
      ref.watch(preferencesLocalStorageDatasourceProvider);

  final LocalStorageRepository<Preferences> localStorageRepository =
      LocalStorageRepositoryImpl(localStorageDatasource);

  return localStorageRepository;
});

final walletLocalStorageDatasourceProvider =
    Provider<LocalStorageDatasource<Wallet>>(
        (ref) => IsarLocalStorageDatasource<Wallet>());

final walletLocalStorageRepositoryProvider =
    Provider<LocalStorageRepository<Wallet>>((ref) {
  final LocalStorageDatasource<Wallet> localStorageDatasource =
      ref.watch(walletLocalStorageDatasourceProvider);

  final LocalStorageRepository<Wallet> localStorageRepository =
      LocalStorageRepositoryImpl(localStorageDatasource);

  return localStorageRepository;
});

final accountLocalStorageDatasourceProvider =
    Provider<LocalStorageDatasource<Account>>(
        (ref) => IsarLocalStorageDatasource<Account>());

final accountLocalStorageRepositoryProvider =
    Provider<LocalStorageRepository<Account>>((ref) {
  final LocalStorageDatasource<Account> localStorageDatasource =
      ref.watch(accountLocalStorageDatasourceProvider);

  final LocalStorageRepository<Account> localStorageRepository =
      LocalStorageRepositoryImpl(localStorageDatasource);

  return localStorageRepository;
});

final assetLocalStorageDatasourceProvider =
    Provider<LocalStorageDatasource<Asset>>(
        (ref) => IsarLocalStorageDatasource<Asset>());

final assetLocalStorageRepositoryProvider =
    Provider<LocalStorageRepository<Asset>>((ref) {
  final LocalStorageDatasource<Asset> localStorageDatasource =
      ref.watch(assetLocalStorageDatasourceProvider);

  final LocalStorageRepository<Asset> localStorageRepository =
      LocalStorageRepositoryImpl<Asset>(localStorageDatasource);

  return localStorageRepository;
});

final blockchainNetworkLocalStorageDatasourceProvider =
    Provider<LocalStorageDatasource<BlockchainNetwork>>(
        (ref) => InMemoryBlockchainNetworkDatasource());

final blockchainNetworkLocalStorageRepositoryProvider =
    Provider<LocalStorageRepository<BlockchainNetwork>>((ref) {
  final LocalStorageDatasource<BlockchainNetwork> localStorageDatasource =
      ref.watch(blockchainNetworkLocalStorageDatasourceProvider);

  final LocalStorageRepository<BlockchainNetwork> localStorageRepository =
      LocalStorageRepositoryImpl(localStorageDatasource);

  return localStorageRepository;
});
