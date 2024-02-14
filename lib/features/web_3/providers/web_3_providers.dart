import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/datasources/_web_3_datasources_impl.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/web_3_repository_impl.dart';
import 'package:web3dart/web3dart.dart';

final isRefreshingBalanceNativeProvider = StateProvider<int>((ref) => 0);

final balanceNativeCurrencyProvider = FutureProvider<double>((ref) async {
  final web3Provider = ref.watch(web3RepositoryProvider);
  final isRefreshingBlanace = ref.watch(isRefreshingBalanceNativeProvider);
  final String? publicKey =
      ref.watch(portfolioStateNotifierProvider).account?.address;

  if (web3Provider == null || publicKey == null) {
    return Future(() => 0.0);
  }

  try {
    final balances = await web3Provider.getNativeBalance(publicKey);

    return balances;
  } catch (e) {
    if (kDebugMode) {
      print('refresh counter: $isRefreshingBlanace');
    }
    return Future(() => -99.99);
    // TODO: agregar feedback del catch
  }
});

final gasPriceProvider = FutureProvider.autoDispose<BigInt>((ref) {
  return ref.watch(web3RepositoryProvider)!.getGasPrice();
});

final web3DatasourceProvider = Provider<Web3Datasource?>((ref) {
  final blockchainNetwork =
      ref.watch(portfolioStateNotifierProvider).blockchainNetwork;
  if (blockchainNetwork == null) return null;
  final client = Web3Client(blockchainNetwork.nodeUrl, Client());

  switch (blockchainNetwork.identity) {
    case BlockchainIdentity.tron:
      return Web3TronApiDatasourceImpl();
    case BlockchainIdentity.mumbai:
    case BlockchainIdentity.goerli:
    case BlockchainIdentity.ethereum:
    case BlockchainIdentity.bnb:
    case BlockchainIdentity.polygon:
      return Web3EthereumDatasourceImpl(web3Client: client);
    default:
      return Web3EthereumDatasourceImpl(web3Client: client);
  }
});

final web3RepositoryProvider = Provider<Web3Repository?>((ref) {
  final Web3Datasource? web3Datasource = ref.watch(web3DatasourceProvider);
  if (web3Datasource == null) return null;
  final Web3Repository web3Repository = Web3RepositoryImpl(web3Datasource);
  return web3Repository;
});
