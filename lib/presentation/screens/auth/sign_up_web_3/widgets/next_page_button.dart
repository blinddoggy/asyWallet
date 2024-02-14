import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextPageButton extends ConsumerWidget {
  const NextPageButton({super.key, this.onPressed, this.label});

  final String? label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context, ref) {
    return FilledButton(
      onPressed: onPressed,
      child: Row(children: [
        Text(label ?? 'Continuar'),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right_outlined,
          size: 24,
        ),
      ]),
    );
  }
}
