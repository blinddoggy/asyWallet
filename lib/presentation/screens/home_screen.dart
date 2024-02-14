import 'package:flutter/material.dart';

import 'package:tradex_wallet_3/presentation/widgets/_widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  static const routeName = 'home_screen';

  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          childView,
        ]),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
