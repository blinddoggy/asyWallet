import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;

import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_providers.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/widgets/next_page_button.dart';

class SeedPhraseVerifyPage extends ConsumerWidget {
  const SeedPhraseVerifyPage({super.key, required this.validationStep});

  final int validationStep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpWeb3stateNotifierProvider);
    final notifier = ref.watch(signUpWeb3stateNotifierProvider.notifier);
    String selectedWord = notifier.getSelectedOptionWord(validationStep) ?? '';

    final int selectedOption = state.userResponses[validationStep];
    handleOptionChange(value) {
      notifier.setUserResponse(validationStep, value);
    }

    const title = 'Confirma tu frase semilla';
    const body =
        'Seleccione cada palabra en el orden en que fue presentado a usted';

    final mediaQuery = MediaQuery.of(context);
    final minHeightConstrain =
        mediaQuery.size.height - (kToolbarHeight + kBottomNavigationBarHeight);

    const vGap = SizedBox(height: 20);

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

            Column(
              children: [
                Text(
                  '${state.mnemonicIndexToValidate[validationStep] + 1}',
                  style: atomic.Display.generate(
                    fontSize: AtFontSize.medium,
                    fontWeight: AtFontWeight.semibold,
                    fontColor: AtFontColor.primary,
                  ),
                ),
                FadeIn(
                  animate: selectedWord != "",
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    selectedWord,
                    key: ValueKey<String>(selectedWord),
                    style: atomic.Display.generate(
                      fontSize: AtFontSize.medium,
                      fontWeight: AtFontWeight.semibold,
                      fontColor: AtFontColor.primary,
                    ),
                  ),
                ),
              ],
            ),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _OutlinedButtonOption(
                    selectedOption: selectedOption,
                    value: index,
                    label: state.posibleResponses![validationStep][index],
                    handleOptionChange: handleOptionChange,
                  ),
                ),
              ),
            ),
            // }

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomIn(
                  animate: selectedWord != '',
                  duration: const Duration(milliseconds: 300),
                  child: NextPageButton(
                    onPressed: () => ref
                        .read(signUpWeb3PageViewControllerProvider.notifier)
                        .nextPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlinedButtonOption extends ConsumerWidget {
  const _OutlinedButtonOption({
    required this.value,
    required this.label,
    this.selectedOption = -1,
    required this.handleOptionChange,
  });
  final int value;
  final String label;

  final int selectedOption;
  final Function(int) handleOptionChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSelected = selectedOption == value;

    final bgColor = isSelected ? CustomColors.primary : Colors.transparent;
    final fontColor = isSelected ? CustomColors.white : CustomColors.primary;

    return OutlinedButton(
      onPressed: () {
        handleOptionChange(value);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        side: const BorderSide(
          strokeAlign: BorderSide.strokeAlignInside,
          color: CustomColors.primary,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fontColor,
        ),
      ),
    );
  }
}
