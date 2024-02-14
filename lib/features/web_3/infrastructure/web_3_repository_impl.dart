import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';

class Web3RepositoryImpl extends Web3Repository {
  // final Web3Datasource datasource;

  Web3RepositoryImpl(super.datasource);

  @override
  Future<double> getNativeBalance(String accountAddress) {
    return datasource.getNativeBalance(accountAddress);
  }

  @override
  Future<List<double>> getBalancesFromTokens(
      {required String publicKey,
      required String jsonRpc,
      required List<String> tokens}) async {
    return datasource.getBalancesFromTokens(
        publicKey: publicKey, jsonRpc: jsonRpc, tokens: tokens);
  }

  @override
  Future<SendTransactionResponseEntity> sendTransaction({
    required String privateKey,
    required Transaction transaction,
  }) {
    return datasource.sendTransaction(
      privateKey: privateKey,
      transaction: transaction,
    );
  }

  @override
  getGasPrice() {
    return datasource.getGasPrice();
  }

  @override
  Future<List<BigInt>> getGasPriceEip1559() {
    return datasource.getGasPriceEip1559();
  }

  @override
  Future<Asset?> fetchTokenInfo({
    required BlockchainIdentity networkIdentity,
    required String addressToken,
  }) {
    return datasource.fetchTokenInfo(
      networkIdentity: networkIdentity,
      addressToken: addressToken,
    );
  }

  @override
  Future<SendTransactionResponseEntity> sendTokenTransaction({
    required String privateKey,
    required Asset asset,
    required Transaction transaction,
  }) {
    return datasource.sendTokenTransaction(
      privateKey: privateKey,
      transaction: transaction,
      asset: asset,
    );
  }
}
