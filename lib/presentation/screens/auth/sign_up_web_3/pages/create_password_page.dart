import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;
import 'package:tradex_wallet_3/domain/validations/form_validator.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_providers.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/widgets/next_page_button.dart';
import 'package:tradex_wallet_3/presentation/screens/common/constants_widgets.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bodyContent =
        'Ingresa la clave de fácil acceso para tu billetera. Ten en cuenta que son cuatro dígitos.';

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/image/shield_3d.png',
                  height: 190,
                  fit: BoxFit.fitHeight,
                ),
                vGap,
                Text(
                  bodyContent,
                  style: atomic.Body.generate(
                    fontSize: AtFontSize.medium,
                    fontColor: AtFontColor.dark,
                  ),
                ),
                vGap,
              ],
            ),
            CreatePasswordForm(),
          ],
        ),
      ),
    );
  }
}

class CreatePasswordForm extends ConsumerWidget {
  CreatePasswordForm({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController inputPinController = TextEditingController();
  final TextEditingController inputConfirmPinController =
      TextEditingController();
  final FocusNode pinFocus = FocusNode();
  final FocusNode confirmPinFocus = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpWeb3UseCase = ref.watch(signUpWeb3UseCaseProvider);
    final state = ref.watch(signUpWeb3stateNotifierProvider);

    submit(String pin) async {
      if (formKey.currentState!.validate()) {
        confirmPinFocus.unfocus();
        if (state.mnemonic == null) throw "Mnemonic can't be Null.";
        await signUpWeb3UseCase.execute(
          pin: inputPinController.text,
          mnemonic: state.mnemonic!,
          name: 'Tradex Wallet',
        );
        ref.read(authUserStateNotifierProvider.notifier).justCreatedAccounts();
        ref.read(signUpWeb3PageViewControllerProvider.notifier).nextPage();
      }
    }

    emptyCounter(BuildContext context,
            {int? currentLength, int? maxLength, bool? isFocused}) =>
        null;
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: inputPinController,
                    obscureText: true,
                    focusNode: pinFocus,
                    obscuringCharacter: '*',
                    autofocus: true,
                    onTapOutside: (event) => pinFocus.unfocus(),
                    maxLength: 4,
                    buildCounter: emptyCounter,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Ingresa el PIN",
                    ),
                    style: const TextStyle(
                      letterSpacing: 30.0,
                    ),
                    validator: (value) {
                      final validator = Validator(value);
                      pinRules() {
                        validator
                          ..isNullOrEmpty()
                          ..isAPin();
                      }

                      return validator.runValue(value, pinRules);
                    },
                  ),
                  vGap,
                  TextFormField(
                    controller: inputConfirmPinController,
                    obscureText: true,
                    focusNode: confirmPinFocus,
                    obscuringCharacter: '*',
                    onTapOutside: (event) => confirmPinFocus.unfocus(),
                    maxLength: 4,
                    buildCounter: emptyCounter,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Confirmar PIN",
                    ),
                    style: const TextStyle(
                      letterSpacing: 30.0,
                    ),
                    validator: (value) {
                      final validator = Validator(value);
                      pinRules() {
                        validator
                          ..isNullOrEmpty()
                          ..isAPin()
                          ..areStringsDifferent(inputPinController.value.text);
                      }

                      return validator.runValue(value, pinRules);
                    },
                  ),
                  vGap,
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NextPageButton(
              onPressed: () => submit(inputPinController.value.text),
            ),
          ],
        ),
      ],
    );
  }
}
