import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const name = NamedRoute.welcome;

  @override
  Widget build(BuildContext context) {
    const vGap = SizedBox(height: 20);
    const paddingSpace = SizedBox(height: 40);

    final mediaQuery = MediaQuery.of(context);
    final minHeightConstrain =
        mediaQuery.size.height - (mediaQuery.padding.top + kToolbarHeight);

    const btnStyle = ButtonStyle(
      minimumSize: MaterialStatePropertyAll<Size>(
        Size(220, 44),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/logos/portfolio_logo.png')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: minHeightConstrain),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    paddingSpace,
                    Image.asset(
                      'assets/image/wallet_3d.png',
                      height: 190,
                    ),
                    vGap,
                    Text(
                      'Bienvenido',
                      style: atomic.Heading.generate(
                        fontSize: AtFontSize.large,
                        fontColor: AtFontColor.primary,
                      ),
                    ),
                    vGap,
                    Text(
                      'Únete a nuestra plataforma y descubre nuevas formas de administrar tus activos digitales.',
                      style: atomic.Body.generate(
                        fontSize: AtFontSize.large,
                        fontColor: AtFontColor.primary,
                      ),
                    ),
                    Text(
                      'Regístrate para acceder a la billetera web 3.0 o crea una cuenta en la versión web 2.5 para comenzar a explorar.',
                      style: atomic.Body.generate(
                        fontSize: AtFontSize.large,
                        fontColor: AtFontColor.primary,
                        fontWeight: AtFontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            context.goNamed(NamedRoute.signUpWeb3);
                          },
                          style: btnStyle,
                          child: const Row(children: [
                            Text('Crear Cuenta'),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right_outlined, size: 24),
                          ]),
                        ),
                      ],
                    ),
                    vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            context.goNamed(NamedRoute.importAccount);
                          },
                          style: btnStyle,
                          child: const Row(children: [
                            Text('Importar Cuenta'),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right_outlined,
                              size: 24,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    paddingSpace,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
