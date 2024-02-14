import 'package:tradex_wallet_3/domain/response_entities/abstract_response_entity.dart';
import 'package:tradex_wallet_3/domain/response_entities/dto/keypair_account_response_dto.dart';

class GetAccountByMnemonicResponseEntity extends ResponseEntity {
  final KeypairAccountResponseDTO? evmKeypair;
  final KeypairAccountResponseDTO? tronKeypair;

  GetAccountByMnemonicResponseEntity({
    required super.isSuccess,
    super.errorMessage,
    this.evmKeypair,
    this.tronKeypair,
  });
}
