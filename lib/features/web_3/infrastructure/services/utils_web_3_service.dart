import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';

import 'package:tradex_wallet_3/features/web_3/infrastructure/models/create_mnemonic_and_accounts_response_model.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/create_mnemonic_response_model.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/get_accounts_by_mnemonic_response_model.dart';

import 'package:tradex_wallet_3/infrastructure/mappers/response_mapper.dart';

class UtilsWeb3Service {
  static const String urlApi = 'kitevibes.com';

  static const Map<EndpointType, String> endpoints = {
    EndpointType.createMnemonic: 'tron/get-mnemonic',
    EndpointType.createMnemonicAndAccountsResponse: 'utils/generate-keypair',
    EndpointType.getAccountByMnemonic: 'utils/get-keypairs',
  };

  static Future<GetAccountByMnemonicResponseEntity> getKeyPairsFromMnemonic(
      String mnemonic) async {
    // final endpoint = 'utils/get-keypairs';
    final endpoint = endpoints[EndpointType.getAccountByMnemonic]!;

    try {
      final url = Uri.http(urlApi, endpoint);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mnemonic': mnemonic}),
      );

      if (response.statusCode == 200) {
        final GetAccountsByMnemonicResponseModel accountsByMnemonicResponse =
            GetAccountsByMnemonicResponseModel.fromJson(
                json.decode(response.body));

        return ResponseMapper.getAccountsByMnemonicResponse(
          isSuccess: true,
          responseModel: accountsByMnemonicResponse,
        );
      } else {
        throw 'Status Code: ${response.statusCode}';
      }
    } catch (error) {
      return GetAccountByMnemonicResponseEntity(
        isSuccess: false,
        errorMessage: 'Error: $error',
      );
    }
  }

  static Future<CreateMnemonicAndAccountsResponseEntity>
      createMnemonicAndAccounts() async {
    // const endpoint = 'utils/generate-keypair';
    final endpoint = endpoints[EndpointType.createMnemonicAndAccountsResponse]!;
    try {
      final url = Uri.http(urlApi, endpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final CreateMnemonicAndAccountsResponseModel
            mnemonicAndAccountsResponseModel =
            CreateMnemonicAndAccountsResponseModel.fromJson(
                json.decode(response.body));

        return ResponseMapper.createMnemonicAndAccountsResponse(
          isSuccess: true,
          responseModel: mnemonicAndAccountsResponseModel,
        );
      } else {
        throw ('Status Code: ${response.statusCode}');
      }
    } catch (error) {
      return CreateMnemonicAndAccountsResponseEntity(
        isSuccess: false,
        errorMessage: 'Error: $error',
      );
    }
  }

  static Future<CreateMnemonicResponseEntity> createMnemonic() async {
    // const endpoint = 'tron/get-mnemonic';
    final endpoint = endpoints[EndpointType.createMnemonic]!;
    try {
      final url = Uri.http(urlApi, endpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final CreateMnemonicResponseModel responseModel =
            CreateMnemonicResponseModel.fromJson(json.decode(response.body));

        return ResponseMapper.createMnemonicResponse(
          isSuccess: true,
          responseModel: responseModel,
        );
      } else {
        throw ('Status Code: ${response.statusCode}');
      }
    } catch (error) {
      return CreateMnemonicResponseEntity(
        isSuccess: false,
        errorMessage: 'Error: $error',
      );
    }
  }
}

enum EndpointType {
  createMnemonic,
  createMnemonicAndAccountsResponse,
  getAccountByMnemonic,
}
