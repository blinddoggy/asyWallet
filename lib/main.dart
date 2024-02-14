import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';

import 'package:tradex_wallet_3/config/config_barel_file.dart';
import 'package:tradex_wallet_3/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await loadFonts();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Tradex Wallet',
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        final isLoggedIn = ref
            .watch(authUserStateNotifierProvider.notifier)
            .validateIsLoggedIn();
        if (isLoggedIn) {
          _startTimer();
        }
        break;
      case AppLifecycleState.resumed:
        _cancelTimer();
        break;
      default:
        break;
    }
  }

  void _startTimer() {
    if (_timer == null || (!_timer!.isActive)) {
      _timer = Timer(const Duration(seconds: 30), () {
        ref.read(authUserStateNotifierProvider.notifier).logout();
      });
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
  }
}
