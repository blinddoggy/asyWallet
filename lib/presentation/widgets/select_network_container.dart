import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';

class SelectNetworkContainer extends StatelessWidget {
  const SelectNetworkContainer({
    super.key,
    required this.blockchainNetwork,
    this.disabled = false,
  });

  final BlockchainNetwork blockchainNetwork;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: disabled
            ? []
            : [
                const BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                    color: Colors.black26)
              ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: CustomColors.lightSpaceGradient,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              fit: BoxFit.cover,
              width: 24,
              height: 24,
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(blockchainNetwork.iconUrl),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            blockchainNetwork.name,
            // style: textTheme.labelLarge,
            style: disabled
                ? AtomicTextStyle.label.largeBold
                    .copyWith(color: CustomColors.graySpace)
                : AtomicTextStyle.label.largeBold,
          ),
        ],
      ),
    );
  }
}
