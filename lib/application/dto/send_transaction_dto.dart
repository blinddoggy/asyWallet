import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/send_transaction_response_entity.dart';

class SendTransactionDTO {
  final Transaction? transaction;
  final SendTransactionResponseEntity? transactionResponse;

  SendTransactionDTO({
    this.transaction,
    this.transactionResponse,
  });

  SendTransactionDTO copyWith({
    Transaction? transaction,
    SendTransactionResponseEntity? transactionResponse,
  }) =>
      SendTransactionDTO(
        transaction: transaction ?? this.transaction,
        transactionResponse: transactionResponse ?? this.transactionResponse,
      );
}
