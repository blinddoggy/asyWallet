import 'package:tradex_wallet_3/domain/response_entities/abstract_response_entity.dart';

class CreateMnemonicResponseEntity extends ResponseEntity {
  final String? mnemonic;

  CreateMnemonicResponseEntity({
    required super.isSuccess,
    super.errorMessage,
    this.mnemonic,
  });
}
