import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/abstract_response_entity.dart';
import 'package:tradex_wallet_3/domain/response_entities/create_mnemonic_and_accounts_response_entity.dart';
import 'package:tradex_wallet_3/domain/response_entities/dto/keypair_account_response_dto.dart';

class AccountResponseDto extends ResponseEntity {
  final KeypairAccountResponseDTO? evmKeypair;
  final KeypairAccountResponseDTO? tronKeypair;

  AccountResponseDto({
    required super.isSuccess,
    super.errorMessage,
    this.evmKeypair,
    this.tronKeypair,
  });

  factory AccountResponseDto.mnemonicAndAccounts(
          CreateMnemonicAndAccountsResponseEntity responseEntity) =>
      AccountResponseDto(
        isSuccess: responseEntity.isSuccess,
        errorMessage: responseEntity.errorMessage,
        evmKeypair: responseEntity.evmKeypair,
        tronKeypair: responseEntity.tronKeypair,
      );
  factory AccountResponseDto.responseEntity(ResponseEntity responseEntity) {
// final response =
    responseEntity as CreateMnemonicAndAccountsResponseEntity;

    return AccountResponseDto(
      isSuccess: responseEntity.isSuccess,
      errorMessage: responseEntity.errorMessage,
      evmKeypair: responseEntity.evmKeypair,
      tronKeypair: responseEntity.tronKeypair,
    );
  }
}
