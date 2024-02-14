import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/dto/portfolio_dto.dart';
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/presentation/widgets/select_account_container.dart';
import 'package:tradex_wallet_3/presentation/widgets/select_network_container.dart';
import 'package:tradex_wallet_3/utils/utils.dart';

class ModuleSelections extends ConsumerStatefulWidget {
  ModuleSelections({
    super.key,
    required this.tradexData,
    this.networkSelectIsDisabled = false,
  });

  final bool networkSelectIsDisabled;

  PortfolioDTO? tradexData;
  List<Account> accounts = [];
  List<BlockchainNetwork> blockchainNetworks = [];

  @override
  ModuleSelectionsState createState() => ModuleSelectionsState();
}

class ModuleSelectionsState extends ConsumerState<ModuleSelections> {
  @override
  void initState() {
    super.initState();
    widget.tradexData = ref.read(portfolioStateNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tradexData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    widget.blockchainNetworks =
        ref.read(portfolioStateNotifierProvider.notifier).getNetworks();
    widget.accounts =
        ref.read(portfolioStateNotifierProvider.notifier).getAccounts();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona una Red',
                style: AtomicTextStyle.label.mediumBold,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: widget.networkSelectIsDisabled
                    ? null
                    : () {
                        Utils.showBottomModal(context,
                            title: "Seleccionar Red",
                            child: _SelectBlockchainNetwork(
                              blockchainNetworks: widget.blockchainNetworks,
                            ));
                      },
                child: SelectNetworkContainer(
                  blockchainNetwork: widget.tradexData!.blockchainNetwork!,
                  disabled: widget.networkSelectIsDisabled,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona una cuenta',
                style: AtomicTextStyle.label.mediumBold,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => Utils.showBottomModal(
                  context,
                  title: "Seleccionar Cuenta",
                  child: _SelectAccount(
                    accounts: widget.accounts
                        .where((account) => account.blockchainNetworks.any(
                            (network) =>
                                network ==
                                widget.tradexData!.blockchainNetwork!.identity))
                        .toList(),
                  ),
                ),
                child: SelectAccountContainer(
                  account: widget.tradexData!.account!,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectBlockchainNetwork extends ConsumerWidget {
  final List<BlockchainNetwork> blockchainNetworks;
  const _SelectBlockchainNetwork({
    required this.blockchainNetworks,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conéctate a la red adecuada para acceder y administrar tus activos digitales. Selecciona una red a continuación para comenzar:",
            style: AtomicTextStyle.body.medium,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: blockchainNetworks.length,
            itemBuilder: (BuildContext context, int index) {
              final network = blockchainNetworks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                    onTap: () {
                      ref
                          .read(portfolioStateNotifierProvider.notifier)
                          .setCurrentBlockchainNetwork(network);
                      Navigator.pop(context);
                    },
                    child: SelectNetworkContainer(blockchainNetwork: network)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectAccount extends ConsumerWidget {
  final List<Account> accounts;
  const _SelectAccount({
    required this.accounts,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selecciona la cuenta",
            style: AtomicTextStyle.body.medium,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) {
              final account = accounts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                    onTap: () {
                      ref
                          .read(portfolioStateNotifierProvider.notifier)
                          .setCurrentAccount(account);
                      Navigator.pop(context);
                    },
                    child: SelectAccountContainer(account: account)),
              );
            },
          ),
        ],
      ),
    );
  }
}
