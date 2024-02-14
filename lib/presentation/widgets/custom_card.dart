import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final double? height;

  const CustomCard({super.key, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      // TODO: migrar este BoxDecoration a algún customTheme
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
      // padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
