import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tradex_wallet_3/config/router/app_router_provider.dart';
import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/features/encrypt/application/encrypt_provider.dart';
import 'package:tradex_wallet_3/features/encrypt/domain/abstract_encrypt.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';

final authUserStateNotifierProvider =
    StateNotifierProvider<AuthUserNotifier, AuthUserState>(
        (ref) => AuthUserNotifier(ref));

class AuthUserState extends Equatable {
  final String? errorMessage;
  final AuthState authState;

  const AuthUserState({
    this.authState = AuthState.loading,
    this.errorMessage,
  });

  copyWith({
    AuthState? authState,
    String? errorMessage,
  }) =>
      AuthUserState(
        authState: authState ?? this.authState,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        authState,
        errorMessage ?? '',
      ];
}

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  final StateNotifierProviderRef _ref;

  final LocalStorageRepository<Account> _accountRepository;
  final LocalStorageRepository<Preferences> _preferencesRepository;
  final EncryptRepository _encryptRepository;

  static const String attemptsKey = 'login_attempts';
  static const String lockTimeKey = 'lock_time';
  static const String isLockedKey = 'app_locked';
  static const Duration lockoutDuration = Duration(minutes: 5);
  static const int maxAttempts = 3;

  AuthUserNotifier(this._ref)
      : _encryptRepository = _ref.watch(encryptProvider),
        _accountRepository = _ref.watch(accountLocalStorageRepositoryProvider),
        _preferencesRepository =
            _ref.watch(preferencesLocalStorageRepositoryProvider),
        super(const AuthUserState()) {
    initState();
  }
  Future<void> initState() async {
    await validateAuthState();
  }

  Future<bool> validateHasAccounts() async {
    final hasAccounts = (await _accountRepository.getAll()).isNotEmpty;
    if (!hasAccounts) state.copyWith(authState: AuthState.onWelcomeOnboarding);
    return hasAccounts;
  }

  void justCreatedAccounts() {
    state = state.copyWith(
      authState: AuthState.justCreatedAccounts,
      errorMessage: null,
    );
  }

  bool validateIsLoggedIn() {
    return state.authState == AuthState.loggedIn;
  }

  Future<bool> validateLoginPIN(String pin) async {
    if (await _validateIsLocked()) {
      return false;
    }

    final preferences = (await _preferencesRepository.getAll()).firstOrNull;
    if (preferences == null) {
      state = state.copyWith(
        errorMessage: "Preferences can't be null",
        authState: AuthState.loggedOut,
      );
      return false;
    }

    final encryptedPin = preferences.pinHash;
    final isLoggedIn = _encryptRepository.verifySHA(pin, encryptedPin);
    state = state.copyWith(
      authState: isLoggedIn ? AuthState.loggedIn : AuthState.loggedOut,
      errorMessage: isLoggedIn ? null : 'Pin incorrecto.',
    );

    if (isLoggedIn) {
      _resetLockedPrefs();
    } else {
      _checkLoginAttempts();
    }

    return isLoggedIn;
  }

  void logout() {
    _resetLockedPrefs();
    state = state.copyWith(
      authState: AuthState.loggedOut,
      errorMessage: null,
    );
    _ref.watch(appRouterProvider).goNamed(NamedRoute.pinLogin);
  }

  Future<bool> _validateIsLocked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isLockedKey) == true) {
      int? lockTime = prefs.getInt(lockTimeKey);
      if (lockTime != null &&
          DateTime.now()
                  .difference(DateTime.fromMillisecondsSinceEpoch(lockTime)) <
              lockoutDuration) {
        state = state.copyWith(
          authState: AuthState.loggedOut,
          errorMessage: "Demasiados intentos. Inténtalo de nuevo más tarde.",
        );
        return true;
      } else {
        state.copyWith(
          authState: AuthState.loggedOut,
          errorMessage: null,
        );
        await _resetLockedPrefs();
      }
    }
    return false;
  }

  Future<void> _checkLoginAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int attempts = prefs.getInt(attemptsKey) ?? 0;
    if (attempts >= maxAttempts) {
      prefs.setBool(isLockedKey, true);
      prefs.setInt(lockTimeKey, DateTime.now().millisecondsSinceEpoch);
    } else {
      attempts++;
      prefs.setInt(attemptsKey, attempts);
    }
  }

  Future<void> _resetLockedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(isLockedKey);
    prefs.remove(lockTimeKey);
    prefs.remove(attemptsKey);
  }

  Future<AuthState> validateAuthState() async {
    if (state.authState != AuthState.justCreatedAccounts) {
      if (!(await validateHasAccounts())) {
        state = state.copyWith(authState: AuthState.onWelcomeOnboarding);
      } else if (await _validateIsLocked()) {
        state = state.copyWith(authState: AuthState.locked);
      }
    }

    switch (state.authState) {
      case AuthState.onWelcomeOnboarding:
        return AuthState.onWelcomeOnboarding;
      case AuthState.locked:
        return AuthState.locked;
      case AuthState.loggedIn:
        return AuthState.loggedIn;
      default:
        return AuthState.loggedOut;
    }
  }
}

enum AuthState {
  onWelcomeOnboarding,
  justCreatedAccounts,
  loggedIn,
  loggedOut,
  locked,
  loading,
}
