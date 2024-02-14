import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_providers.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/widgets/next_page_button.dart';
import 'package:tradex_wallet_3/presentation/screens/common/constants_widgets.dart';

class InstructionsPage extends ConsumerWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCase = ref.watch(signUpWeb3UseCaseProvider);
    final state = ref.read(signUpWeb3stateNotifierProvider);

    const title = 'Asegura tu billetera';
    const subtitle =
        'La frase semilla es el respaldo para recuperar tu billetera.';
    const body =
        '''Escriba su frase inicial en una hoja de papel y guárdela en un lugar seguro.

Si omites la recomendación anterior, los riesgos son:
  • Lo pierdes.
  • Olvidas dónde lo pusiste.
  • Alguien más lo encuentra.''';

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
                FadeInUp(
                  child: Image.asset(
                    'assets/image/rocket_3d.png',
                    height: 190,
                  ),
                ),
                vGap,
                Text(
                  title,
                  style: atomic.Heading.generate(
                      fontSize: AtFontSize.large,
                      fontColor: AtFontColor.primary),
                ),
                vGap,
                Text(
                  subtitle,
                  style: atomic.Body.generate(
                    fontSize: AtFontSize.large,
                    fontColor: AtFontColor.primary,
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NextPageButton(
                  onPressed: () async {
                    if (state.mnemonic == null) {
                      final response = await useCase.createMnemonicAndAccount();
                      if (response.isSuccess &&
                          response.mnemonic != null &&
                          response.mnemonic!.isNotEmpty) {
                        ref
                            .read(signUpWeb3stateNotifierProvider.notifier)
                            .setMnemonicUseCaseResponse(response);
                        ref
                            .read(signUpWeb3PageViewControllerProvider.notifier)
                            .nextPage();
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
