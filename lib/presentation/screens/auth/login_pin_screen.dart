import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';

import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';
import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;

import 'package:tradex_wallet_3/domain/validations/form_validator.dart';
import 'package:tradex_wallet_3/presentation/screens/common/constants_widgets.dart';

class LoginPinScreen extends ConsumerWidget {
  const LoginPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bodyContent =
        'Ingresa la clave de fácil acceso para tu billetera. Ten en cuenta que son cuatro dígitos.';

    return Scaffold(
      body: SingleChildScrollView(
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
              LoginPinForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPinForm extends ConsumerWidget {
  LoginPinForm({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController inputPinController = TextEditingController();
  final FocusNode pinFocus = FocusNode();
  final FocusNode confirmPinFocus = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(authUserStateNotifierProvider).errorMessage;

    goToPorfolio() {
      context.goNamed(NamedRoute.portfolio);
    }

    submit() async {
      if (formKey.currentState!.validate()) {
        final isLoggedIn = await ref
            .read(authUserStateNotifierProvider.notifier)
            .validateLoginPIN(inputPinController.text);
        if (isLoggedIn) {
          goToPorfolio();
        }
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => submit(),
                    decoration: InputDecoration(
                      labelText: "Ingresa el PIN",
                      errorText: errorMessage,
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

                      String? validatorMessage =
                          validator.runValue(value, pinRules);

                      return validatorMessage;
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
            ShakeX(
              animate: errorMessage != null,
              child: FilledButton(
                onPressed: submit,
                child: const Text('Iniciar Sesión'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
