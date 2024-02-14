import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/send_transaction_response_entity.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';

class SendAssetCurrencyUseCase {
  final Web3Repository _web3Repository;

  SendAssetCurrencyUseCase(this._web3Repository);

  Future<SendTransactionResponseEntity> execute({
    required String privateKey,
    required Transaction transaction,
    required Asset asset,
  }) async {
    final SendTransactionResponseEntity response =
        await _web3Repository.sendTokenTransaction(
      privateKey: privateKey,
      asset: asset,
      transaction: transaction,
    );

    if (response.isSuccess) {
      // TODO: save localstorage transaction
      // La transacción fue exitosa, puedes realizar acciones adicionales aquí.
    } else {
      // TODO: save error (error.log)
      // La transacción falló, maneja el error adecuadamente.
      // throw TransactionFailure(response.errorMessage!);
    }

    return response;
  }
}

class TransactionFailure implements Exception {
  final String message;
  TransactionFailure(this.message);
}
