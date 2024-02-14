import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/_config_theme_barel_file.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/dto/transaction_action_info_dto.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/views/tokens_section.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/widgets/_widgets_barel_file.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/widgets/transaction_action_button.dart';
import 'package:tradex_wallet_3/presentation/widgets/_widgets.dart';
import 'package:tradex_wallet_3/presentation/widgets/trade/receive_modal_content.dart';
import 'package:tradex_wallet_3/presentation/widgets/trade/send_modal_content.dart';
import 'package:tradex_wallet_3/utils/utils.dart';
import 'package:tradex_wallet_3/features/web_3/providers/web_3_providers.dart';

class PortfolioView extends ConsumerWidget {
  const PortfolioView({super.key});
  static const routeName = 'portfolio';
  static const name = 'PortfolioView';

  @override
  Widget build(BuildContext context, ref) {
    final tradexData = ref.watch(portfolioStateNotifierProvider);
    final balanceFutureProvider = ref.watch(balanceNativeCurrencyProvider);

    if (tradexData.blockchainNetwork == null || tradexData.account == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<TransactionActionInfoDTO> transactionActions = [
      TransactionActionInfoDTO(
        label: 'Enviar',
        route: '/${PortfolioView.routeName}',
        icon: Icons.rocket_launch_outlined,
        action: () => Utils.showBottomModal(context,
            title: 'Enviar', child: const SendModalContent()),
      ),
      TransactionActionInfoDTO(
          label: 'Recibir',
          route: '/${PortfolioView.routeName}',
          icon: Icons.transit_enterexit_outlined,
          action: () => Utils.showBottomModal(context,
              title: 'Recibir', child: const ReceiveModalContent())),
      const TransactionActionInfoDTO(
        label: 'Comercio',
        route: '/${PortfolioView.routeName}',
        icon: Icons.add_card_outlined,
      ),
      const TransactionActionInfoDTO(
        label: 'SWAP',
        route: '/${PortfolioView.routeName}',
        icon: Icons.swap_vert_outlined,
      ),
      const TransactionActionInfoDTO(
        label: 'Historial',
        route: '/${PortfolioView.routeName}',
        icon: Icons.history_outlined,
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            Image.asset(
              'assets/logos/portfolio_logo.png',
              height: 35,
            ),
            const SizedBox(height: 16),
            balanceFutureProvider.when(data: (nativeBalance) {
              return BalanceCard(
                balance: nativeBalance,
                decimals: tradexData.blockchainNetwork!.decimals ?? 0,
                symbol: tradexData.blockchainNetwork!.nativeCurrency,
              );
            }, error: (Object error, StackTrace st) {
              return Text('error $st');
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Portafolio', style: AtomicTextStyle.heading.smallPrimary),
                FilledButton(
                  onPressed: () {
                    Utils.showBottomModal(
                      context,
                      title: 'Agregar Activo',
                      child: const AddAssetModalContent(),
                    );
                  },
                  style: AppTheme.buttonStyleIconSmall,
                  child: const Row(children: [
                    Text('Agregar Token'),
                    SizedBox(width: 4),
                    Icon(Icons.add_task_outlined),
                  ]),
                )
              ],
            ),
            const TokensSection()
          ],
        ),
      ),
    );
  }
}
