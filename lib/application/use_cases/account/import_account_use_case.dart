import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/services/utils_web_3_service.dart';

class ImportAccountUseCase {
  final LocalStorageRepository<Account> accountStorageRepository;

  ImportAccountUseCase({required this.accountStorageRepository});

  Future<List<Account>?> execute({
    required String mnemonic,
    required String name,
  }) async {
    final response = await UtilsWeb3Service.getKeyPairsFromMnemonic(mnemonic);

    if (response.isSuccess) {
      final List<Account> accounts = [];
      if (response.tronKeypair != null) {
        accounts.add(Account(
          name: name,
          address: response.tronKeypair!.publicKey,
          privateKey: response.tronKeypair!.privateKey,
          blockchainNetworks: response.tronKeypair!.blockchainIdentities,
        ));
      }
      if (response.evmKeypair != null) {
        accounts.add(Account(
          name: name,
          address: response.evmKeypair!.publicKey,
          privateKey: response.evmKeypair!.privateKey,
          blockchainNetworks: response.evmKeypair!.blockchainIdentities,
        ));
      }

      if (accounts.isNotEmpty) {
        accountStorageRepository.saveAll(accounts);
      }

      return accounts;
    } else {
      // TODO: save error (error.log)
      // La importación falló, maneja el error adecuadamente.
      throw ImportAccountFailure(response.errorMessage!);
      // return null;
    }

    // return response;
  }
}

class ImportAccountFailure implements Exception {
  final String message;
  ImportAccountFailure(this.message);
  @override
  String toString() {
    return message;
  }
}
