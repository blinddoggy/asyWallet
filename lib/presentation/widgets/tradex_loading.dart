import 'package:flutter/material.dart';

class TradexLoading extends StatelessWidget {
  const TradexLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/logos/logo_vertical.png'),
        const SizedBox(height: 20),
        const CircularProgressIndicator.adaptive()
      ]),
    );
  }
}
