import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/presentation/providers/assets_provider.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/dto/transaction_action_info_dto.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/widgets/transaction_action_button.dart';
import 'package:tradex_wallet_3/presentation/widgets/trade/receive_modal_content.dart';
import 'package:tradex_wallet_3/presentation/widgets/trade/send_asset_modal_content.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';
import 'package:tradex_wallet_3/utils/utils.dart';

import 'package:tradex_wallet_3/presentation/screens/portfolio/widgets/_widgets_barel_file.dart';
import 'package:tradex_wallet_3/presentation/widgets/_widgets.dart';

final assetProvider = FutureProvider.family<Asset?, int>(
    (ref, id) => ref.watch(assetLocalStorageRepositoryProvider).getById(id));

class AssetView extends ConsumerWidget {
  static const routeName = 'asset_view';
  static const name = 'asset_view';
  final String assetId;

  const AssetView(this.assetId, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final asset = ref.watch(assetProvider(int.parse(assetId)));

    final List<TransactionActionInfoDTO> transactionActions = [
      TransactionActionInfoDTO(
        label: 'Enviar',
        route: '/${AssetView.routeName}',
        icon: Icons.rocket_launch_outlined,
        action: () {
          asset.when(
            data: (asset) {
              if (asset == null) return const Text('Token not found');
              Utils.showBottomModal(context,
                  title: 'Enviar', child: SendAssetModalContent(asset));
            },
            error: (_, __) => {const Text('error')},
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      TransactionActionInfoDTO(
        label: 'Recibir',
        route: '/${AssetView.routeName}',
        icon: Icons.transit_enterexit_outlined,
        action: () => Utils.showBottomModal(
          context,
          title: 'Recibir',
          child: const ReceiveModalContent(),
        ),
      ),
      const TransactionActionInfoDTO(
        label: 'Historial',
        route: '/${AssetView.routeName}',
        icon: Icons.history_outlined,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: asset.when(
          data: (asset) => Text(asset!.name),
          error: (_, __) => const Text('Token Error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      body: asset.when(
        data: (asset) {
          if (asset == null) return const Center(child: Text('404 NotFound'));
          return _AssetView(asset, transactionActions: transactionActions);
        },
        error: (_, __) => const Text('Token Error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _AssetView extends ConsumerWidget {
  const _AssetView(this.asset, {required this.transactionActions});

  final Asset asset;
  final List<TransactionActionInfoDTO> transactionActions;

  @override
  Widget build(BuildContext context, ref) {
    final balanceFutureProvider =
        ref.watch(balanceAssetFutureProvider(asset.address));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: Column(
          children: [
            balanceFutureProvider.when(data: (balance) {
              return BalanceCard(
                balance: balance,
                decimals: asset.decimals,
                symbol: asset.symbol,
                isAsset: true,
              );
            }, error: (Object error, StackTrace st) {
              return Text('error $st');
            }, loading: () {
              return const CustomCard(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final action in transactionActions)
                      TransactionActionButton(action: action)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
