import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';

class MoleculeBalance extends StatelessWidget {
  const MoleculeBalance(
      {super.key,
      required this.balance,
      required this.symbol,
      this.small = false});

  final String balance;
  final String symbol;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: balance,
                  style: small
                      ? AtomicTextStyle.label.mediumBold
                      : AtomicTextStyle.display.largePrimaryBold,
                ),
                TextSpan(
                  text: ' $symbol',
                  style: small
                      ? AtomicTextStyle.label.mediumLight
                      : AtomicTextStyle.display.largePrimaryLigth,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
