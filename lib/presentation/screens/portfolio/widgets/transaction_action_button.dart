import 'package:flutter/material.dart';

import 'package:tradex_wallet_3/config/theme/atomic_text_theme.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/dto/transaction_action_info_dto.dart';

class TransactionActionButton extends StatelessWidget {
  final TransactionActionInfoDTO action;

  const TransactionActionButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = action.action == null;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: disabled
                    ? []
                    : [
                        const BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: CustomColors.lightSpaceGradient),
              ),
              child: IconButton(
                onPressed: action.action,
                icon: Icon(
                  action.icon,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                action.label,
                style: AtomicTextStyle.button.mediumSecondarySemibold
                    .copyWith(color: CustomColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
