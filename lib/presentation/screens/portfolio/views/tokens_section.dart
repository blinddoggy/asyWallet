import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/config/theme/_config_theme_barel_file.dart';
import 'package:tradex_wallet_3/presentation/providers/assets_provider.dart';
import 'package:tradex_wallet_3/utils/utils.dart';

class TokensSection extends ConsumerWidget {
  const TokensSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assets = ref.watch(assetsStateNotifierProvider);
    final balanceProviderRef = ref.watch(balanceAssetsProvider(assets));
    const hGap = SizedBox(width: 16);

    if (assets.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Aún no has agregado ningún token.',
          style: AtomicTextStyle.label.mediumSemibold,
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return ref.read(assetsStateNotifierProvider.notifier).loadAssets();
        },
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: assets.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final asset = assets[index];
            return GestureDetector(
              onTap: () {
                context.goNamed(
                  NamedRoute.portfolioAssetDetail,
                  pathParameters: {'id': '${asset.isarId}'},
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CustomColors.lightSilver,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage(
                        width: 44,
                        height: 44,
                        fit: BoxFit.contain,
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: NetworkImage(asset.icon),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/icon/icon-ring.png',
                          width: 44,
                          height: 44,
                        ),
                      ),
                    ),
                    hGap,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(asset.symbol,
                              style: AtomicTextStyle.heading.mediumSecondary
                                  .copyWith(color: CustomColors.darkSpace)),
                          Text(asset.name,
                              style: AtomicTextStyle.label.mediumLight
                                  .copyWith(color: CustomColors.darkSpace)),
                        ],
                      ),
                    ),
                    hGap,
                    balanceProviderRef.when(
                        data: (List<double> balanceList) {
                          final currentBalance = Utils.ajustedBalanceDecimals(
                              balanceList[index], asset.decimals);
                          return Text(
                            currentBalance
                                .toStringAsFixed(currentBalance == 0 ? 1 : 2),
                            style: AtomicTextStyle.heading.mediumSecondary
                                .copyWith(color: CustomColors.darkSpace),
                          );
                        },
                        error: (Object error, StackTrace st) {
                          return Text('error $st');
                        },
                        loading: () => const CircularProgressIndicator())
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
