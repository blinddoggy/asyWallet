import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';

import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/pages/_pages.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_notifier.dart';
import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_providers.dart';
import 'package:tradex_wallet_3/presentation/screens/common/message_screen.dart';
import 'package:tradex_wallet_3/presentation/widgets/atoms/atom_page_view_indicator.dart';

class SignUpWeb3Screen extends ConsumerWidget {
  const SignUpWeb3Screen({Key? key}) : super(key: key);
  static const routeName = NamedRoute.signUpWeb3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signUpWeb3stateNotifierProvider.notifier);

    final pageControllerState = ref.watch(signUpWeb3PageViewControllerProvider);
    final pageController =
        ref.watch(signUpWeb3PageViewControllerProvider.notifier).pageController;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: pageController.initialPage == pageControllerState.page
            ? null
            : IconButton(
                onPressed: () => ref
                    .read(signUpWeb3PageViewControllerProvider.notifier)
                    .prevPage(),
                icon: const Icon(Icons.chevron_left_outlined),
              ),
        title: AtomPageViewIndicator(
          currentPage: pageControllerState.page,
          pageCount: pageControllerState.pageCount,
          width: (MediaQuery.of(context).size.width * 0.4),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            ref.read(signUpWeb3PageViewControllerProvider.notifier).goTo(index);
          },
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const InstructionsPage(),
            const SeedPhrasePage(),
            ...List.generate(
              SignUpWeb3State.validationsAmount,
              (index) => SeedPhraseVerifyPage(
                validationStep: index,
              ),
            ),
            notifier.validateMnemonicVerification()
                ? const CreatePasswordPage()
                : MessageScreen(
                    messageType: MessageType.error,
                    title: 'Lo sentimos',
                    body:
                        'Las respuestas de validación de la frase mnemónica son incorrectas.\n Intenta nuevamente.',
                    callback: () {
                      const revealMnemonicPage = 1;
                      ref
                          .read(signUpWeb3PageViewControllerProvider.notifier)
                          .goTo(revealMnemonicPage);
                    },
                    buttonContent: const Text('Volver'),
                  ),
            MessageScreen(
              messageType: MessageType.success,
              title: '¡Muy bien!',
              body:
                  'Has protegido con éxito tu billetera. Recuerda mantener segura tu frase semilla.\n ¡Es tu responsabilidad!',
              callback: () {
                ref.invalidate(signUpWeb3PageViewControllerProvider);
                ref.invalidate(signUpWeb3stateNotifierProvider);
                ref.invalidate(signUpWeb3UseCaseProvider);
                ref
                    .watch(authUserStateNotifierProvider.notifier)
                    .validateAuthState()
                    .then((authState) {
                  if (authState == AuthState.loggedIn) {
                    context.goNamed(NamedRoute.portfolio);
                  } else {
                    context.goNamed(NamedRoute.pinLogin);
                  }
                });
              },
              buttonContent: const Text('Finalizar'),
            )
          ],
        ),
      ),
    );
  }
}
