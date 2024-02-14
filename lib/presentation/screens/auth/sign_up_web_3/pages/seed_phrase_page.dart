import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_providers.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/widgets/blur_wall.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/widgets/next_page_button.dart';
import 'package:tradex_wallet_3/presentation/screens/common/constants_widgets.dart';

class SeedPhrasePage extends ConsumerWidget {
  const SeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpWeb3stateNotifierProvider);

    const title = 'Escribe tu frase semilla';
    const body =
        'Esta es tu frase semilla. Escríbala en un papel y guárdela en un lugar seguro. Se le pedirá que vuelva a ingresar esta frase (en orden) en el siguiente paso. ';

    final mediaQuery = MediaQuery.of(context);
    final minHeightConstrain =
        mediaQuery.size.height - (kToolbarHeight + kBottomNavigationBarHeight);

    final mnemonic = state.mnemonicArray;
    final isActive = state.isBlurWallActive;

    final hideWallFunction =
        ref.read(signUpWeb3stateNotifierProvider.notifier).turnOffBlurWall;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: minHeightConstrain),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    title,
                    style: atomic.Heading.generate(
                        fontSize: AtFontSize.medium,
                        fontColor: AtFontColor.primary),
                  ),
                ),
                vGap,
                Text(
                  body,
                  style: atomic.Body.generate(
                    fontSize: AtFontSize.medium,
                    fontColor: AtFontColor.dark,
                  ),
                ),
                vGap,
              ],
            ),
            mnemonic.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      Column(
                        children: List.generate(
                          6,
                          (index) => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: CustomColors.graySpace,
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${index + 1}: ${mnemonic[index]}',
                                    style: atomic.Label.generate(
                                      fontSize: AtFontSize.large,
                                      fontColor: AtFontColor.light,
                                      fontWeight: AtFontWeight.regular,
                                    ),
                                  )),
                                ),
                              ),
                              hGap,
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: CustomColors.graySpace,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 6 + 1}: ${mnemonic[index + 6]}',
                                      style: atomic.Label.generate(
                                        fontSize: AtFontSize.large,
                                        fontColor: AtFontColor.light,
                                        fontWeight: AtFontWeight.regular,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlurWall(
                        isActive: isActive,
                        hideFunction: hideWallFunction,
                      )
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NextPageButton(
                  onPressed: () => ref
                      .read(signUpWeb3PageViewControllerProvider.notifier)
                      .nextPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
