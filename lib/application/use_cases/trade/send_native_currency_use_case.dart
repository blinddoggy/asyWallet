// Capa de Aplicación (Application Layer)

import 'package:tradex_wallet_3/domain/entities/transaction.dart';
import 'package:tradex_wallet_3/domain/response_entities/send_transaction_response_entity.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';
// import 'package:tradex_weallet_3/domain/entities/crypto_transaction.dart';
// import 'package:tradex_weallet_3/domain/repositories/crypto_wallet_repository.dart';

class SendNativeCurrencyUseCase {
  final Web3Repository _web3Repository;

  SendNativeCurrencyUseCase(this._web3Repository);

  Future<SendTransactionResponseEntity> execute(
      String privateKey, Transaction transaction) async {
    // Realiza validaciones de negocio aquí, si es necesario
    // Por ejemplo, verifica si el usuario tiene suficiente saldo para la transacción.

    final SendTransactionResponseEntity response = await _web3Repository
        .sendTransaction(transaction: transaction, privateKey: privateKey);

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
