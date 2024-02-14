import 'package:tradex_wallet_3/application/use_cases/account/dto/account_response_dto.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';

class SaveAccountsUseCase {
  final LocalStorageRepository<Account> accountStorageRepository;

  SaveAccountsUseCase({required this.accountStorageRepository});

  Future<List<Account>?> execute({
    required AccountResponseDto response,
    required String name,
  }) async {
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
      throw SaveAccountFailure(response.errorMessage!);
      // return null;
    }

    // return response;
  }
}

class SaveAccountFailure implements Exception {
  final String message;
  SaveAccountFailure(this.message);
  @override
  String toString() {
    return message;
  }
}
