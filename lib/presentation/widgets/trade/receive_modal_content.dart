import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/_config_theme_barel_file.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/utils/utils.dart';

import 'package:qr_flutter/qr_flutter.dart';

class ReceiveModalContent extends ConsumerWidget {
  const ReceiveModalContent({super.key});

  // final QrImageView

  @override
  Widget build(BuildContext context, ref) {
    final currentAccountAddress =
        ref.watch(portfolioStateNotifierProvider).account?.address;

    const vGap = SizedBox(height: 20);
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escanea el código QR para copiar dirección.',
            style: AtomicTextStyle.body.medium,
          ),
          vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: CustomColors.white,
                ),
                child: currentAccountAddress == null
                    ? const Center(child: CircularProgressIndicator())
                    : QrImageView(
                        data: currentAccountAddress,
                        version: QrVersions.auto,
                        size: 190.0,
                      ),
              ),
            ],
          ),
          vGap,
          Text(
            'Dirección de la cuenta: ',
            style: AtomicTextStyle.label.mediumSemibold,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: CustomColors.darkSilver),
            ),
            child: currentAccountAddress == null
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.shortAddress(currentAccountAddress)),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: currentAccountAddress),
                            ); // Copia el texto al portapapeles
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Dirección de la cuenta copiada'),
                            ));
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 24,
                          )),
                    ],
                  ),
          ),
          // vGap,
          // vGap,
        ],
      ),
    );
  }
}
