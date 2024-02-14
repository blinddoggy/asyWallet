import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:tradex_wallet_3/config/router/named_route.dart';

import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/_atomic_font_styles.dart'
    as atomic;
import 'package:tradex_wallet_3/config/theme/atomic_font_styles.dart/font_style_parameters.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key, required this.errorMessage});
  static const routeName = 'RouteError';
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/image/circular_exclamation_3d.png',
              height: 190,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage,
                  style: atomic.Body.generate(fontSize: AtFontSize.large),
                ),
              ),
            ),
            FilledButton(
                onPressed: () {
                  context.goNamed(NamedRoute.portfolio);
                },
                child: const Text('Go Home'))
          ],
        ),
      ),
    );
  }
}
