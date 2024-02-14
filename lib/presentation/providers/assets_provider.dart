import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/dto/portfolio_dto.dart';
import 'package:tradex_wallet_3/domain/entities/asset.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';
import 'package:tradex_wallet_3/features/web_3/providers/web_3_providers.dart';

final balanceAssetsProvider =
    FutureProvider.family<List<double>, List<Asset>?>((ref, assets) async {
  final String publicKey =
      ref.watch(portfolioStateNotifierProvider).account?.address ?? "";
  final String jsonRPC =
      ref.watch(portfolioStateNotifierProvider).blockchainNetwork?.nodeUrl ??
          "";
  final tokenAddresses = assets?.map((asset) => asset.address).toList() ?? [];

  final web3Provider = ref.watch(web3RepositoryProvider);
  if (web3Provider == null) return [];
  final balances = web3Provider.getBalancesFromTokens(
      publicKey: publicKey, jsonRpc: jsonRPC, tokens: tokenAddresses);
  return balances;
});

final balanceAssetFutureProvider = FutureProvider.family
    .autoDispose<double, String>((ref, tokenAddresses) async {
  final String publicKey =
      ref.watch(portfolioStateNotifierProvider).account?.address ?? "";
  final String jsonRPC =
      ref.watch(portfolioStateNotifierProvider).blockchainNetwork?.nodeUrl ??
          "";

  final web3Provider = ref.watch(web3RepositoryProvider);
  if (web3Provider == null) return -99.99;
  final balances = await web3Provider.getBalancesFromTokens(
      publicKey: publicKey, jsonRpc: jsonRPC, tokens: [tokenAddresses]);
  return balances.first;
});

final assetsStateNotifierProvider =
    StateNotifierProvider<AssetsNotifier, List<Asset>>(
        (ref) => AssetsNotifier(ref));

class AssetsNotifier extends StateNotifier<List<Asset>> {
  // ignore: unused_field
  final StateNotifierProviderRef<AssetsNotifier, List<Asset>> _ref;

  final LocalStorageRepository<Asset> _assetRepository;
  final PortfolioDTO _porfolioProvider;

  AssetsNotifier(this._ref)
      : _assetRepository = _ref.read(assetLocalStorageRepositoryProvider),
        _porfolioProvider = _ref.watch(portfolioStateNotifierProvider),
        super([]) {
    loadAssets();
  }

  Future<void> loadAssets() async {
    try {
      final assets = (await _assetRepository.getAll())
          .where((asset) =>
              _porfolioProvider.blockchainNetwork?.identity ==
              asset.blockchainNetworkIdentity)
          .toList();

      state = assets;
    } catch (e) {
      // TODO: agregar feedback del catch
    }
  }

  Future<void> saveAsset(Asset asset) async {
    state = [asset, ...state];
    await _assetRepository.save(asset);
  }
}
