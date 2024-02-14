import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/presentation/screens/portfolio/views/portfolio_view.dart';
import 'package:tradex_wallet_3/presentation/screens/settings/views/settings_view.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  static const List<_TabInfo> _tabs = [
    _TabInfo(
      label: 'Billetera',
      route: '/${PortfolioView.routeName}',
      icon: Icons.account_balance_wallet_outlined,
    ),
    _TabInfo(
      label: 'NFT',
      route: '/nft',
      icon: Icons.image_outlined,
    ),
    _TabInfo(
      label: 'Ajustes',
      route: '/${SettingsView.routeName}',
      icon: Icons.settings_outlined,
    ),
  ];

  int getCurrentIndex(BuildContext context) {
    final String? location = GoRouterState.of(context).fullPath;
    final currentIndex = _tabs.indexWhere((tab) => location == tab.route);
    return currentIndex < 0 ? 0 : currentIndex;
  }

  void onItemTapped(BuildContext context, int index) {
    context.go(_tabs[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4.0,
            color: Colors.black26,
          )
        ],
        gradient: LinearGradient(colors: CustomColors.whiteGradient),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
        child: BottomNavigationBar(
            currentIndex: getCurrentIndex(context),
            onTap: (value) => onItemTapped(context, value),
            items: [
              for (final tab in _tabs)
                BottomNavigationBarItem(
                  icon: Icon(
                    tab.icon,
                    size: 32,
                  ),
                  label: tab.label,
                ),
            ]),
      ),
    );
  }
}

class _TabInfo {
  final String label;
  final String route;
  final IconData icon;

  const _TabInfo(
      {required this.label, required this.route, required this.icon});
}
