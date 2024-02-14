import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/presentation/providers/blockchain_network_providers.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/presentation/widgets/_widgets.dart';
import 'package:tradex_wallet_3/presentation/widgets/modules/module_selections.dart';
import 'package:tradex_wallet_3/presentation/widgets/molecules/molecule_balance.dart';
import 'package:tradex_wallet_3/utils/utils.dart';
import 'package:tradex_wallet_3/features/web_3/providers/web_3_providers.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.symbol,
    required this.decimals,
    this.isAsset = false,
  });

  // final FutureProvider<double> balanceFutureProvider;
  final double balance;
  final String symbol;
  final int decimals;
  final bool isAsset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networks = ref.watch(blockchainNetworksProvider);

    return networks.when(
        data: (networks) {
          return _BalanceCardView(
            balance: balance,
            symbol: symbol,
            decimals: decimals,
            isAsset: isAsset,
          );
        },
        error: (_, __) => const Center(child: Text('Error')),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class _BalanceCardView extends ConsumerWidget {
  final double balance;
  final String symbol;
  final int decimals;
  final bool isAsset;

  const _BalanceCardView({
    required this.balance,
    required this.symbol,
    required this.decimals,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    final tradexData = ref.watch(portfolioStateNotifierProvider);
    if (tradexData.blockchainNetwork == null || tradexData.account == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentBalance = Utils.ajustedBalanceDecimals(balance, decimals);
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onDoubleTap: () => ref
                  .read(isRefreshingBalanceNativeProvider.notifier)
                  .update((state) => state++),
              child: Column(
                children: [
                  Text('Balance',
                      style: AtomicTextStyle.heading.smallSecondary),
                  const SizedBox(height: 8),
                  MoleculeBalance(
                    balance: currentBalance.toStringAsFixed(2),
                    symbol: symbol,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ModuleSelections(
              tradexData: tradexData,
              networkSelectIsDisabled: isAsset,
            )
          ],
        ),
      ),
    );
  }
}
