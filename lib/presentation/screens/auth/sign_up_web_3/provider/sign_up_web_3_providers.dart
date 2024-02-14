import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/use_cases/sign_up_web_3/sign_up_web_3_use_case.dart';
import 'package:tradex_wallet_3/features/encrypt/application/encrypt_provider.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';

import 'package:tradex_wallet_3/presentation/screens/auth/sign_up_web_3/provider/sign_up_web_3_notifier.dart';
import 'package:tradex_wallet_3/presentation/screens/providers/page_view_controller_notifier.dart';

final signUpWeb3stateNotifierProvider =
    StateNotifierProvider<SignUpWeb3Notifier, SignUpWeb3State>(
        (ref) => SignUpWeb3Notifier());

final signUpWeb3UseCaseProvider = Provider((ref) {
  final encryptRepository = ref.watch(encryptProvider);
  final preferencesStorageRepository =
      ref.watch(preferencesLocalStorageRepositoryProvider);
  final accountStorageRepository =
      ref.watch(accountLocalStorageRepositoryProvider);

  final signUpWeb3UseCase = SignUpWeb3UseCase(
    preferencesStorageRepository: preferencesStorageRepository,
    accountStorageRepository: accountStorageRepository,
    encryptRepository: encryptRepository,
  );

  return signUpWeb3UseCase;
});

final signUpWeb3PageViewControllerProvider =
    StateNotifierProvider<PageViewControllerNotifier, PageViewControllerState>(
        (ref) =>
            PageViewControllerNotifier(4 + SignUpWeb3State.validationsAmount));
