import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/application/use_cases/account/import_account_use_case.dart';
import 'package:tradex_wallet_3/application/providers/auth_user_state_notifier_provider.dart';
import 'package:tradex_wallet_3/config/router/named_route.dart';
import 'package:tradex_wallet_3/domain/entities/account.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';
import 'package:tradex_wallet_3/presentation/widgets/tradex_loading.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';
import 'package:tradex_wallet_3/features/web_3/providers/web_3_providers.dart';

class ImportAccountBusinessLogic {
  final BuildContext context;
  final WidgetRef ref;
  late LocalStorageRepository<Account> accountLocalStorageRepository;

  late Web3Repository? web3repository;

  get isLoading => (web3repository == null);

  final loadingWidget = const Center(child: TradexLoading());

  ImportAccountBusinessLogic({
    required this.context,
    required this.ref,
  })  : web3repository = ref.watch(web3RepositoryProvider),
        accountLocalStorageRepository =
            ref.watch(accountLocalStorageRepositoryProvider);

  showScaffoldMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  redirectPorfolio() {
    context.goNamed(NamedRoute.portfolio);
    showScaffoldMessage('Cuenta importada correctamente.');
  }

  void createAccount({
    required String mnemonic,
    required String name,
  }) async {
    final createAccountUseCase = ImportAccountUseCase(
      accountStorageRepository: accountLocalStorageRepository,
    );
    try {
      final accounts = await createAccountUseCase.execute(
        mnemonic: mnemonic,
        name: name,
      );
      if (accounts == null) {
        throw Exception("Failed to create the account");
      } else {
        final currentAccounts = ref
            .read(portfolioStateNotifierProvider.notifier)
            .filterAccountsByCurrentBlockchain(accounts);

        ref.read(portfolioStateNotifierProvider.notifier)
          ..addAccountToUi(currentAccounts)
          ..setCurrentAccount(currentAccounts.first);

        if (ref
            .read(authUserStateNotifierProvider.notifier)
            .validateIsLoggedIn()) {
          redirectPorfolio();
        } else {
          // TODO: agregar CreatePasswordPage PIN
          // ref.read(appRouteStateNotifierProvider).isLoggedIn = true;
        }
      }
    } catch (e) {
      showScaffoldMessage('''La cuenta no pudo ser importada.
Por favor valida que la frase sea la correcta.''');
    }
  }
}
