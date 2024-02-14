import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;

enum MessageType {
  information,
  warning,
  error,
  success,
}

class MessageScreen extends ConsumerWidget {
  const MessageScreen({
    super.key,
    required this.messageType,
    required this.callback,
    required this.buttonContent,
    this.title,
    this.body,
  });

  final MessageType messageType;
  final void Function() callback;
  final Widget buttonContent;
  final String? title;
  final String? body;

  String getImageUrl() {
    switch (messageType) {
      case MessageType.information:
        return 'assets/logos/logo_vertical.png';
      case MessageType.warning:
        return 'assets/image/circular_exclamation_3d.png';
      case MessageType.error:
        return 'assets/image/circular_exclamation_3d.png';
      case MessageType.success:
        return 'assets/image/circular_check_3d.png';
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final vGap = Container(height: 20);

    final mediaQuery = MediaQuery.of(context);
    final minHeightConstrain =
        mediaQuery.size.height - (kToolbarHeight + kBottomNavigationBarHeight);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: minHeightConstrain),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ElasticIn(
                  child: Image.asset(getImageUrl(), height: 190),
                ),
                vGap,
                FadeIn(
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    style: atomic.Heading.generate(
                        fontSize: AtFontSize.large,
                        fontColor: AtFontColor.primary),
                  ),
                ),
                vGap,
                Text(
                  body ?? '',
                  textAlign: TextAlign.center,
                  style: atomic.Body.generate(
                    fontSize: AtFontSize.large,
                    fontColor: AtFontColor.dark,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(onPressed: callback, child: buttonContent)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
