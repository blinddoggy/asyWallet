import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class Utils {
  static String shortAddress(String address) {
    if (address.length < 10) {
      return address;
    }

    final primeros5Caracteres = address.substring(0, 9);
    final ultimos4Caracteres = address.substring(address.length - 4);

    final cadenaFinal = '$primeros5Caracteres...$ultimos4Caracteres';

    return cadenaFinal;
  }

  static double ajustedBalanceDecimals(double balance, int decimalAmount) {
    return balance / math.pow(10, decimalAmount);
  }

  static BigInt double2Wei(double amount) {
    final amountInWei = amount * math.pow(10, 18);
    return BigInt.from(amountInWei);
  }

  static num fixAmountDecimalsFactorToUi(double amount, int decimals) {
    final parsedAmount = amount / math.pow(10, decimals);
    return parsedAmount;
  }

  static num fixAmountDecimalsFactorToBlockchain(double amount, int decimals) {
    final parsedAmount = amount * math.pow(10, decimals);
    return parsedAmount;
  }

  static void showBottomModal(context,
      {required String title, required Widget child, Widget? leading}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: const BoxConstraints(minHeight: 100, maxHeight: 500),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: CustomColors.spaceGradient),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 64, height: 64, child: leading),
                      Text(title, style: AtomicTextStyle.heading.smallPrimary),
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                              size: 24,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 16, right: 16),
                    child: child,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
