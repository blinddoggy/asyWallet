import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;

class BlurWall extends ConsumerWidget {
  const BlurWall({
    super.key,
    required this.isActive,
    required this.hideFunction,
  });

  final bool isActive;
  final void Function() hideFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const vGap = SizedBox(height: 20);

    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: ZoomOut(
        animate: !isActive,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: CustomColors.primary.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Presiona para revelar tu frase',
                    style: atomic.Heading.generate(
                        fontSize: AtFontSize.medium,
                        fontColor: AtFontColor.light,
                        fontWeight: AtFontWeight.bold),
                  ),
                  vGap,
                  Text(
                    'Asegúrate de que nadie más esté viendo tu pantalla.',
                    style: atomic.Body.generate(
                      fontSize: AtFontSize.medium,
                      fontColor: AtFontColor.light,
                    ),
                  ),
                  vGap,
                  FilledButton.icon(
                    onPressed: hideFunction,
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    label: const Text('Revelar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
