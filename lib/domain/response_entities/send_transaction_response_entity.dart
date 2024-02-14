import 'package:tradex_wallet_3/domain/response_entities/abstract_response_entity.dart';

class SendTransactionResponseEntity extends ResponseEntity {
  final String? transactionHash;

  SendTransactionResponseEntity({
    required super.isSuccess,
    super.errorMessage,
    this.transactionHash,
  });

  @override
  String toString() {
    return 'SendTransactionResponseEntity{isSuccess: $isSuccess, transactionHash: $transactionHash, errorMessage: $errorMessage}';
  }
}
