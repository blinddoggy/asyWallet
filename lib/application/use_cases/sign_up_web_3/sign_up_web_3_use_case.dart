import 'package:tradex_wallet_3/application/use_cases/account/dto/account_response_dto.dart';
import 'package:tradex_wallet_3/application/use_cases/account/save_account_use_case.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/create_mnemonic_and_accounts_response_entity.dart';
import 'package:tradex_wallet_3/features/encrypt/domain/abstract_encrypt.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/services/utils_web_3_service.dart';

class SignUpWeb3UseCase {
  final LocalStorageRepository<Account> accountStorageRepository;
  final LocalStorageRepository<Preferences> preferencesStorageRepository;
  final EncryptRepository encryptRepository;

  final SaveAccountsUseCase saveAccountUseCase;

  SignUpWeb3UseCase({
    required this.preferencesStorageRepository,
    required this.accountStorageRepository,
    required this.encryptRepository,
  }) : saveAccountUseCase = SaveAccountsUseCase(
            accountStorageRepository: accountStorageRepository);

  CreateMnemonicAndAccountsResponseEntity? mnemonicAndAccountResponse;

  Future<CreateMnemonicAndAccountsResponseEntity>
      createMnemonicAndAccount() async {
    final response = await UtilsWeb3Service.createMnemonicAndAccounts();
    mnemonicAndAccountResponse = response;

    return response;
  }

  Future<List<Account>?> execute({
    required String mnemonic,
    required String name,
    required String pin,
  }) async {
    if (mnemonicAndAccountResponse == null) return [];
    final response =
        AccountResponseDto.responseEntity(mnemonicAndAccountResponse!);

    saveNewPinAndMnemonic(
      pin: pin,
      mnemonic: mnemonic,
    );

    final accounts =
        await saveAccountUseCase.execute(response: response, name: name);

    return accounts;
  }

  saveNewPinAndMnemonic({required String pin, required String mnemonic}) async {
    final currentPreferences =
        (await preferencesStorageRepository.getAll()).firstOrNull;
    if (currentPreferences == null) throw 'Loading Preferences Error';

    if (currentPreferences.pinHash.isEmpty) {
      final newPreferences = currentPreferences.copyWith(
        pinHash: encryptRepository.encryptSHA(pin),
        mnemonicHash: encryptRepository.encryptAES(pin, mnemonic),
      );
      preferencesStorageRepository.save(newPreferences);
    }
    /* 
      TODO: update pin feature
        * remember to update accounts private key too 
    */
  }
}
