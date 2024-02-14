import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/send_transaction_response_entity.dart';

abstract class AbstractWeb3 {
  Future<double> getNativeBalance(String accountAddress);

  Future<BigInt> getGasPrice();
  Future<List<BigInt>> getGasPriceEip1559();

  Future<Asset?> fetchTokenInfo({
    required BlockchainIdentity networkIdentity,
    required String addressToken,
  });

  Future<SendTransactionResponseEntity> sendTransaction({
    required String privateKey,
    required Transaction transaction,
  });

  Future<SendTransactionResponseEntity> sendTokenTransaction({
    required String privateKey,
    required Transaction transaction,
    required Asset asset,
  });

  Future<List<double>> getBalancesFromTokens(
      {required String publicKey,
      required String jsonRpc,
      required List<String> tokens});
}

abstract class Web3Datasource extends AbstractWeb3 {}

abstract class Web3Repository extends AbstractWeb3 {
  final Web3Datasource datasource;
  Web3Repository(this.datasource);
}

abstract class Web3Service extends AbstractWeb3 {
  // setTokenInfo();
}
