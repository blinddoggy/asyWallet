import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';
import 'package:tradex_wallet_3/presentation/providers/theme_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});
  static const routeName = 'settings';
  static const name = 'Settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    return SafeArea(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificaciones'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme Changer'),
            onTap: () {
              context.goNamed(NamedRoute.settingsThemeChanger);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Importar Cuenta'),
            onTap: () {
              context.goNamed(NamedRoute.settingsImportAccount);
            },
          ),
          ListTile(
            leading: Icon(isDarkmode ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Modo Oscuro'),
            onTap: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkmode();
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              ref.read(authUserStateNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
