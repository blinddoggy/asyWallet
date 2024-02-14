import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';
import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/domain/middlewares/middleware_pipeline.dart';
import 'package:tradex_wallet_3/presentation/screens/_screens.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final appRouterProvider = Provider<GoRouter>((ref) {
  final initialRoute = NamedRoute.getPath(NamedRoute.pinLogin);
  final welcomePath = NamedRoute.getPath(NamedRoute.welcome);
  final loginPath = NamedRoute.getPath(NamedRoute.pinLogin);

  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: initialRoute,
    redirect: (BuildContext context, GoRouterState state) async {
      final authenticationState = await ref
          .read(authUserStateNotifierProvider.notifier)
          .validateAuthState();

      final bool isOnOnboarding =
          authenticationState == AuthState.onWelcomeOnboarding;
      final bool isLoggedIn = authenticationState == AuthState.loggedIn;

      final isGoingToWelcome = state.fullPath?.startsWith(welcomePath) ?? false;
      final isGoingToLogin = state.fullPath == loginPath;

      final hasAccountsValidation = MiddlewareValidation(
        name: 'HasAccountsValidation',
        redirectTo: NamedRoute.getFullPath(NamedRoute.welcome),
        validation: () => isOnOnboarding && !isGoingToWelcome,
      );

      final alreadyHasAccounts = MiddlewareValidation(
        name: 'AlreadyHasAccounts',
        redirectTo: NamedRoute.getFullPath(NamedRoute.pinLogin),
        validation: () => !isOnOnboarding && isGoingToWelcome,
      );

      final isNotLoggedIn = MiddlewareValidation(
        name: 'IsNotLoggedIn',
        redirectTo: NamedRoute.getFullPath(NamedRoute.pinLogin),
        validation: () => !isLoggedIn && !isGoingToLogin && !isGoingToWelcome,
      );

      MiddlewarePipeline initMiddleware = MiddlewarePipeline();
      initMiddleware
        ..addMiddleware(hasAccountsValidation)
        ..addMiddleware(alreadyHasAccounts)
        ..addMiddleware(isNotLoggedIn);

      return initMiddleware.executePipeline();
    },
    routes: [
      GoRoute(
          name: NamedRoute.welcome,
          path: NamedRoute.getPath(NamedRoute.welcome),
          builder: (context, state) => WelcomeScreen(key: state.pageKey),
          routes: [
            GoRoute(
              name: NamedRoute.signUpWeb3,
              path: NamedRoute.getPath(NamedRoute.signUpWeb3),
              builder: (context, state) => SignUpWeb3Screen(
                key: state.pageKey,
              ),
            ),
            GoRoute(
              name: NamedRoute.importAccount,
              path: NamedRoute.getPath(NamedRoute.importAccount),
              builder: (context, state) => ImportAccountScreen(
                key: state.pageKey,
              ),
            ),
          ]),
      GoRoute(
        name: NamedRoute.pinLogin,
        path: NamedRoute.getPath(NamedRoute.pinLogin),
        builder: (context, state) => LoginPinScreen(key: state.pageKey),
        redirect: (context, state) async {
          final bool isLoggedIn = ref
              .read(authUserStateNotifierProvider.notifier)
              .validateIsLoggedIn();

          final isGoingToLogin = state.fullPath == loginPath;

          final alreadyIsLoggedIn = MiddlewareValidation(
            name: 'AlreadyIsLoggedIn',
            redirectTo: NamedRoute.getPath(NamedRoute.portfolio),
            validation: () => isLoggedIn && isGoingToLogin,
          );

          MiddlewarePipeline loginPinMiddleware = MiddlewarePipeline();
          loginPinMiddleware.addMiddleware(alreadyIsLoggedIn);

          return loginPinMiddleware.executePipeline();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) =>
            HomeScreen(key: state.pageKey, childView: child),
        routes: [
          GoRoute(
            name: NamedRoute.portfolio,
            path: NamedRoute.getPath(NamedRoute.portfolio),
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PortfolioView(),
            ),
            routes: [
              GoRoute(
                // parentNavigatorKey: _shellNavigator,
                name: NamedRoute.portfolioAssetDetail,
                path: NamedRoute.getPath(NamedRoute.portfolioAssetDetail),
                builder: (context, state) {
                  final assetId = state.pathParameters['id'].toString();
                  return AssetView(assetId, key: state.pageKey);
                },
              )
            ],
          ),
          // GoRoute(
          //   name: NamedRoute.nft,
          //   path: NamedRoute.getPath(NamedRoute.nft),
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     key: state.pageKey,
          //     child: NftView(),
          //   ),
          // ),
          GoRoute(
            name: SettingsView.name,
            path: '/${SettingsView.routeName}',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsView(),
            ),
            routes: [
              GoRoute(
                name: NamedRoute.settingsImportAccount,
                path: NamedRoute.getPath(NamedRoute.importAccount),
                builder: (context, state) => const ImportAccountScreen(),
              ),
              GoRoute(
                name: NamedRoute.settingsThemeChanger,
                path: NamedRoute.getPath(NamedRoute.settingsThemeChanger),
                builder: (context, state) => const ThemeChangerScreen(),
              )
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => RouteErrorScreen(
      errorMessage: state.error.toString(),
      key: state.pageKey,
    ),
  );
});
