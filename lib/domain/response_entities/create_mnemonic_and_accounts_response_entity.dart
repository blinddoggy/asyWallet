import 'package:tradex_wallet_3/domain/response_entities/abstract_response_entity.dart';
import 'package:tradex_wallet_3/domain/response_entities/dto/keypair_account_response_dto.dart';

class CreateMnemonicAndAccountsResponseEntity extends ResponseEntity {
  final String? mnemonic;
  final KeypairAccountResponseDTO? evmKeypair;
  final KeypairAccountResponseDTO? tronKeypair;

  CreateMnemonicAndAccountsResponseEntity({
    required super.isSuccess,
    super.errorMessage,
    this.mnemonic,
    this.evmKeypair,
    this.tronKeypair,
  });
}
