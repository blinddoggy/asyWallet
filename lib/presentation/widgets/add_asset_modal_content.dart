import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/presentation/providers/assets_provider.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/features/web_3/providers/web_3_providers.dart';

class AddAssetModalContent extends ConsumerStatefulWidget {
  const AddAssetModalContent({super.key});

  @override
  AddAssetModalContentState createState() => AddAssetModalContentState();
}

class AddAssetModalContentState extends ConsumerState<AddAssetModalContent> {
  late TextEditingController tokenAddressController;
  Asset? asset;
  @override
  void initState() {
    super.initState();
    tokenAddressController = TextEditingController();
    asset = null;
  }

  @override
  void dispose() {
    tokenAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tradexData = ref.watch(portfolioStateNotifierProvider);
    final web3 = ref.watch(web3RepositoryProvider);
    final assetNotififier = ref.watch(assetsStateNotifierProvider.notifier);
    if (web3 == null || tradexData.blockchainNetwork == null) {
      return const CircularProgressIndicator();
    }

    Future<void> onContinuePressed() async {
      asset = await web3.fetchTokenInfo(
        networkIdentity: tradexData.blockchainNetwork!.identity,
        addressToken: tokenAddressController.text,
      );
      setState(() {});
    }

    closeModal() => Navigator.pop(context);

    Future<void> saveAsset() async {
      if (asset != null) {
        await assetNotififier.saveAsset(asset!);
        closeModal();
      }
    }

    const vGap = SizedBox(height: 20);

    if (asset == null) {
      return Container(
        constraints: const BoxConstraints(maxHeight: 150, minHeight: 100),
        // height: 416,
        child: Column(
          children: [
            TextField(
              controller: tokenAddressController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Dirección del activo',
                labelStyle: AtomicTextStyle.label.largeSemibold,
              ),
            ),
            vGap,
            ElevatedButton(
                onPressed: onContinuePressed, child: const Text('Validar'))
          ],
        ),
      );
    }

    return SizedBox(
      // height: double.infinity,
      height: 416,
      child: Column(
        children: [
          // if (asset.transactionResponse!.transactionHash != null)
          _OutputItem(
            label: 'Nombre',
            content: asset!.name,
          ),
          vGap,
          _OutputItem(
            label: 'Símbolo',
            content: asset!.symbol,
          ),
          vGap,
          _OutputItem(
            label: 'Decimales',
            content: '${asset!.decimals}',
          ),
          vGap,
          const Spacer(),
          ElevatedButton(
              onPressed: saveAsset, child: const Text('Guardar Activo'))
        ],
      ),
    );
  }
}

class _OutputItem extends StatelessWidget {
  const _OutputItem({
    // super.key,
    // required this.asset,
    required this.label,
    required this.content,
  });
  final String label;
  final String content;
  // final Asset? asset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(
                  text: content)); // Copia el texto al portapapeles
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$label copiado'),
              ));
            },
            child: Column(
              children: [
                Text(label, style: AtomicTextStyle.heading.smallSecondary),
                Text(content, style: AtomicTextStyle.body.lead),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* class SendModalContent extends ConsumerStatefulWidget {
  const SendModalContent({super.key});
  @override
  SendModalContentState createState() => SendModalContentState();
}

class SendModalContentState extends ConsumerState<SendModalContent> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    final tradexData = ref.watch(portfolioStateNotifierProvider);
    final nativeBalance = ref.watch(balanceNativeCurrencyProvider);
    final pageController =
        ref.watch(sendTranactionStateNotifierProvider.notifier).pageController;

    return SizedBox(
      height: 416,
      child: PageView(
        controller: pageController,
        children: [
          SendTransactionFormPage(
            tradexData: tradexData,
            nativeBalance: nativeBalance,
            toController: toController,
            amountController: amountController,
            onContinuePressed: () {
              ref
                  .read(sendTranactionStateNotifierProvider.notifier)
                  .setTransaction(Transaction(
                      id: 1,
                      amount: double.parse(amountController.text),
                      blockchainNetworkName: tradexData.blockchainNetwork!.name,
                      receiverAddress: toController.text,
                      senderAddress: tradexData.account!.address,
                      timestamp: DateTime.now()));
              FocusScope.of(context).unfocus();
              ref.read(sendTranactionStateNotifierProvider.notifier).nextPage();
            },
          ),
          SendTransactionConfirmationPage(
            onConfirmPressed: () async {
              final web3Repository = ref.read(web3RepositoryProvider);
              final sendTransactionDTO =
                  ref.read(sendTranactionStateNotifierProvider);
              if (web3Repository == null ||
                  sendTransactionDTO.transaction == null ||
                  tradexData.account == null) return;
              final String privateKey = tradexData.account!.privateKey;
              final senderNativeCurrency =
                  SendNativeCurrencyUseCase(web3Repository);
              ref.read(sendTranactionStateNotifierProvider.notifier).nextPage();

              final response = await senderNativeCurrency.execute(
                  privateKey, sendTransactionDTO.transaction!);

              ref
                  .read(sendTranactionStateNotifierProvider.notifier)
                  .setTransactionResponse(response);
            },
          ),
          const SendTransactionResponsePage(),
        ],
      ),
    );
  }
}

class SendTransactionFormPage extends StatelessWidget {
  const SendTransactionFormPage({
    super.key,
    required this.tradexData,
    required this.nativeBalance,
    required this.onContinuePressed,
    required this.toController,
    required this.amountController,
  });
  final VoidCallback onContinuePressed;
  final PortfolioDTO tradexData;
  final AsyncValue<double> nativeBalance;
  final TextEditingController toController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModuleSelections(tradexData: tradexData),
        const SizedBox(height: 20),
        Text('Cantidad', style: AtomicTextStyle.heading.smallSecondary),
        // Text('1.0', style: AtomicTextStyle.display.largePrimaryBold),
        TextField(
          controller: amountController,
          textAlign: TextAlign.center,
          style: AtomicTextStyle.display.largePrimaryBold,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '  0',
            hintStyle: AtomicTextStyle.display.largePrimaryBold,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Balance', style: AtomicTextStyle.label.mediumSemibold),
            nativeBalance.when(data: (nativeBalance) {
              final currentBalance = Utils.ajustedBalanceDecimals(
                  nativeBalance, tradexData.blockchainNetwork?.decimals ?? 0);
              return TextSpan(
                  text: ' ${currentBalance.toStringAsFixed(6)} ',
                  style: AtomicTextStyle.label.mediumBold);
            }, error: (Object error, StackTrace st) {
              return TextSpan(text: 'error $st');
            }, loading: () {
              return const TextSpan(text: '...');
            }),
            TextSpan(
                text: '${tradexData.blockchainNetwork?.nativeCurrency}',
                style: AtomicTextStyle.label.mediumLight),
          ]),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: TextField(
            // obscureText: true,
            // strutStyle: ,
            controller: toController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Dirección del destinatario',
              labelStyle: AtomicTextStyle.label.largeSemibold,
            ),
            // style
          ),
        ),
        const Spacer(),
        ElevatedButton(
            onPressed: onContinuePressed, child: const Text('Continuar'))
      ],
    );
  }
}

class SendTransactionConfirmationPage extends ConsumerWidget {
  // final Transaction? transaction2;
  final VoidCallback onConfirmPressed;

  const SendTransactionConfirmationPage(
      {super.key, required this.onConfirmPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction =
        ref.watch(sendTranactionStateNotifierProvider).transaction;
    final gasPrice = ref.watch(gasPriceProvider);
    if (transaction == null) {
      return const Center(child: CircularProgressIndicator());
    }

    const standarGap = SizedBox(height: 20);
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Text("Cantidad", style: AtomicTextStyle.heading.smallSecondary),
          Text("${transaction.amount}",
              style: AtomicTextStyle.display.largePrimaryBold),
          standarGap,
          Text("Red", style: AtomicTextStyle.heading.smallSecondary),
          Text(transaction.blockchainNetworkName,
              style: AtomicTextStyle.body.lead),
          standarGap,
          GestureDetector(
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: transaction.senderAddress),
              ); // Copia el texto al portapapeles
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Cuenta de origen copiada'),
              ));
            },
            child: Column(
              children: [
                Text("Cuenta de origen",
                    style: AtomicTextStyle.heading.smallSecondary),
                Text(Utils.shortAddress(transaction.senderAddress),
                    style: AtomicTextStyle.body.lead),
              ],
            ),
          ),
          standarGap,
          Text("Dirección del destinatario",
              style: AtomicTextStyle.heading.smallSecondary),
          Text(Utils.shortAddress(transaction.receiverAddress),
              style: AtomicTextStyle.body.lead),
          const Spacer(),
          ElevatedButton(
            onPressed: onConfirmPressed,
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}

class SendTransactionResponsePage extends ConsumerWidget {
  const SendTransactionResponsePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dto = ref.watch(sendTranactionStateNotifierProvider);
    if (dto.transaction == null || dto.transactionResponse == null) {
      return const Center(child: CircularProgressIndicator());
    }

    const standarGap = SizedBox(height: 20);
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          reponseMessage(dto.transactionResponse!.isSuccess),
          standarGap,
          Text("Cantidad", style: AtomicTextStyle.heading.smallSecondary),
          Text("${dto.transaction!.amount}", style: AtomicTextStyle.body.lead),
          standarGap,
          Text("Red", style: AtomicTextStyle.heading.smallSecondary),
          Text(dto.transaction!.blockchainNetworkName,
              style: AtomicTextStyle.body.lead),
          standarGap,
          Text("Cuenta de origen",
              style: AtomicTextStyle.heading.smallSecondary),
          Text(Utils.shortAddress(dto.transaction!.senderAddress),
              style: AtomicTextStyle.body.lead),
          standarGap,
          Text("Dirección del destinatario",
              style: AtomicTextStyle.heading.smallSecondary),
          Text(Utils.shortAddress(dto.transaction!.receiverAddress),
              style: AtomicTextStyle.body.lead),
          standarGap,
          if (dto.transactionResponse!.transactionHash != null)
            GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(
                    text: dto.transactionResponse!
                        .transactionHash!)); // Copia el texto al portapapeles
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Dirección de la transacción copiado'),
                ));
              },
              child: Column(
                children: [
                  Text("Dirección de la transacción",
                      style: AtomicTextStyle.heading.smallSecondary),
                  Text(
                      Utils.shortAddress(
                          dto.transactionResponse!.transactionHash!),
                      style: AtomicTextStyle.body.lead),
                ],
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }

  SizedBox gap() => const SizedBox(height: 20);

  Row reponseMessage(bool isSuccess) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
            isSuccess
                ? Icons.check_circle_outline_outlined
                : Icons.warning_amber_outlined,
            color: isSuccess ? CustomColors.primary : CustomColors.accent,
            size: 24),
        const SizedBox(width: 8),
        Text(isSuccess ? 'Transacción Completada' : 'Transacción Fallida',
            style: AtomicTextStyle.label.largeSemibold.copyWith(
                color: isSuccess ? CustomColors.primary : CustomColors.accent))
      ],
    );
  }
}
 */