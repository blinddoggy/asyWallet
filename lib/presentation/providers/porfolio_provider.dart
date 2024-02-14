import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/dto/portfolio_dto.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';

final portfolioStateNotifierProvider =
    StateNotifierProvider<PorfolioNotifier, PortfolioDTO>((ref) {
  return PorfolioNotifier(ref);
});

class PorfolioNotifier extends StateNotifier<PortfolioDTO> {
  // ignore: unused_field
  final StateNotifierProviderRef _ref;
  final LocalStorageRepository<BlockchainNetwork> _networkRepository;
  final LocalStorageRepository<Account> _accountrepository;
  // final LocalStorageRepository<Wallet> _walletRepository;

  List<BlockchainNetwork> _networks = [];
  List<Account> _accounts = [];

  PorfolioNotifier(this._ref)
      : _accountrepository = _ref.watch(accountLocalStorageRepositoryProvider),
        // _walletRepository = _ref.watch(walletLocalStorageRepositoryProvider),
        _networkRepository =
            _ref.watch(blockchainNetworkLocalStorageRepositoryProvider),
        super(PortfolioDTO()) {
    loadPortfolioDTO();
  }

  Future<void> loadPortfolioDTO() async {
    await loadBlockchainNetworks();
    loadAccount();
  }

  List<BlockchainNetwork> getNetworks() {
    return _networks;
  }

  List<Account> getAccounts() {
    return _accounts;
  }

  setCurrentBlockchainNetwork(BlockchainNetwork network) {
    state = state.copyWith(blockchainNetwork: network);
    loadAccount();
  }

  setCurrentAccount(Account account) {
    state = state.copyWith(account: account);
  }

  Future<void> loadBlockchainNetworks() async {
    _networks = await _networkRepository.getAll();
    if (_networks.isNotEmpty) {
      state = state.copyWith(blockchainNetwork: _networks.first);
    }
  }

  Future<void> loadAccount({Account? newAccount}) async {
    _accounts =
        filterAccountsByCurrentBlockchain(await _accountrepository.getAll());
    if (_accounts.isNotEmpty &&
        (state.account == null ||
            !state.account!.blockchainNetworks.any(
                (network) => network == state.blockchainNetwork!.identity))) {
      state = state.copyWith(account: _accounts.first);
    }
    state = state.copyWith(account: null);
  }

  void addAccountToUi(List<Account> accounts) {
    final filteredAccounts = filterAccountsByCurrentBlockchain(accounts);
    _accounts.addAll(filteredAccounts);
  }

  List<Account> filterAccountsByCurrentBlockchain(List<Account> accounts) {
    if (accounts.isEmpty || state.blockchainNetwork == null) return [];
    return accounts
        .where((account) => account.blockchainNetworks
            .any((network) => network == state.blockchainNetwork!.identity))
        .toList();
  }
}
