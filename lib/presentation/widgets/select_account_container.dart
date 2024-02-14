import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/domain/entities/account.dart';
import 'package:tradex_wallet_3/utils/utils.dart';

class SelectAccountContainer extends StatelessWidget {
  const SelectAccountContainer({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 2), blurRadius: 4.0, color: Colors.black26)
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: CustomColors.lightSpaceGradient,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const FadeInImage(
              fit: BoxFit.cover,
              width: 24,
              height: 24,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  'https://womenkiteboarding.com/wp-content/uploads/2019/12/Best-Kiteboards-for-Women-Kiteboarders-e1580334356728.jpg'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    account.name,
                    // style: textTheme.labelMedium,
                    style: AtomicTextStyle.label.mediumBold,
                  ),
                ),
                FittedBox(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: [
                      TextSpan(
                          text: Utils.shortAddress(account.address),
                          style: AtomicTextStyle.label.smallLight),
                      // TextSpan(
                      //     text: ' SOL', style: AtomicTextStyle.label.smallBold),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
