import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tradex_wallet_3/domain/entities/_entities.dart' as entities;
import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';

import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/tron_responses/_tron_responses.dart';

class Web3TronApiDatasourceImpl extends Web3Datasource {
  static const String apiUrl = 'kitevibes.com';

  @override
  Future<entities.Asset?> fetchTokenInfo({
    required entities.BlockchainIdentity networkIdentity,
    required String addressToken,
  }) async {
    const endpoint = 'tron/token-info';
    try {
      final url = Uri.http(
          apiUrl, '$endpoint/$addressToken/THPvaUhoh2Qn2y9THCZML3H815hhFhn5YC');
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        final TronInfoTrc20ResponseModel response =
            TronInfoTrc20ResponseModel.fromJson(json.decode(respuesta.body));

        final entities.Asset asset = entities.Asset(
          name: response.name,
          address: addressToken,
          balance: 0,
          blockchainNetworkIdentity: networkIdentity,
          symbol: response.symbol,
          // INFO: se corrigen los decimales en el api (por eso se dejan los decimales en 0).
          decimals: 0,
          // TODO: Añadir aquí la lógica para obtener el icono
          icon: '',
        );

        return asset;
      } else {
        throw 'Error status code: ${respuesta.statusCode}';
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<double>> getBalancesFromTokens({
    required String publicKey,
    required String jsonRpc,
    required List<String> tokens,
  }) async {
    List<double> balances = [];

    for (String tokenAddress in tokens) {
      const endpoint = 'tron/balance-trc20';
      try {
        final url = Uri.http(apiUrl, '$endpoint/$publicKey/$tokenAddress');
        final respuesta = await http.get(url);

        if (respuesta.statusCode == 200) {
          final TronBalanceTrc20ResponseModel response =
              TronBalanceTrc20ResponseModel.fromJson(
                  json.decode(respuesta.body));

          balances.add(response.balance);
        } else {
          balances.add(-99.99);
        }
      } catch (error) {
        balances.add(-99.99);
      }
    }

    return balances;
  }

  @override
  Future<BigInt> getGasPrice() async {
    // TODO: implement getGasPrice
    throw UnimplementedError();
  }

  @override
  Future<List<BigInt>> getGasPriceEip1559() {
    // TODO: implement getGasPriceEip1559
    throw UnimplementedError();
  }

  @override
  Future<double> getNativeBalance(String accountAddress) async {
    const endpoint = 'tron/balance-trx';
    try {
      final url = Uri.http(apiUrl, '$endpoint/$accountAddress');
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        final TronBalanceTrxResponseModel response =
            TronBalanceTrxResponseModel.fromJson(json.decode(respuesta.body));
        return response.balanceTrc20;
      } else {
        // print('Error: ${respuesta.statusCode}');
        return -99.99; // ¿Podría ser mejor devolver null o lanzar una excepción aquí?
      }
    } catch (error) {
      // print('Error: $error');
      return -99.99; // ¿Podría ser mejor devolver null o lanzar una excepción aquí?
    }
  }

  @override
  Future<SendTransactionResponseEntity> sendTransaction({
    required String privateKey,
    required entities.Transaction transaction,
  }) async {
    const endpoint = 'tron/send-trx';
    try {
      var url = Uri.http(apiUrl, endpoint);
      var cuerpo = json.encode({
        'toPublicKey': transaction.receiverAddress,
        'amount': transaction.amount,
        'fromPrivateKey': privateKey,
      });

      var respuesta = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: cuerpo,
      );

      if (respuesta.statusCode == 200) {
        final TronSendTrxResponseModel response =
            TronSendTrxResponseModel.fromJson(json.decode(respuesta.body));
        return SendTransactionResponseEntity(
          isSuccess: true,
          transactionHash: response.result.txid,
        );
      } else {
        return SendTransactionResponseEntity(
          isSuccess: false,
          errorMessage: 'Error: status code: ${respuesta.statusCode}',
        );
      }
    } catch (error) {
      return SendTransactionResponseEntity(
          isSuccess: false, errorMessage: error.toString());
    }
  }

  @override
  Future<SendTransactionResponseEntity> sendTokenTransaction({
    required String privateKey,
    required entities.Asset asset,
    required entities.Transaction transaction,
  }) async {
    if (transaction.tokenAddress == null) throw 'Missing token address.';
    const endpoint = 'tron/send-trc20';

    final url = Uri.http(apiUrl, endpoint);
    final cuerpo = json.encode({
      'tokenAddress': transaction.tokenAddress,
      'toPublicKey': transaction.receiverAddress,
      'amount': transaction.amount,
      'fromPrivateKey': privateKey,
    });

    final respuesta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    try {
      if (respuesta.statusCode == 200) {
        final TronSendTrc20ResponseModel response =
            TronSendTrc20ResponseModel.fromJson(json.decode(respuesta.body));
        return SendTransactionResponseEntity(
          isSuccess: true,
          transactionHash: response.result,
        );
      } else {
        throw 'Status Code: ${respuesta.statusCode}';
      }
    } catch (e) {
      return SendTransactionResponseEntity(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
