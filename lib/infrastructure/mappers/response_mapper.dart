import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';
import 'package:tradex_wallet_3/domain/response_entities/dto/keypair_account_response_dto.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/create_mnemonic_and_accounts_response_model.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/create_mnemonic_response_model.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/get_accounts_by_mnemonic_response_model.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/models/send_transaction_response_model.dart';

class ResponseMapper {
  static SendTransactionResponseEntity sendTransactionResponse(
      SendTransactionResponseModel responseModel) {
    return SendTransactionResponseEntity(
        isSuccess: responseModel.isSuccess,
        transactionHash: responseModel.transactionHash,
        errorMessage: responseModel.errorMessage);
  }

  static GetAccountByMnemonicResponseEntity getAccountsByMnemonicResponse({
    required bool isSuccess,
    required GetAccountsByMnemonicResponseModel responseModel,
    String? errorMessage,
  }) {
    KeypairAccountResponseDTO? evmKeypair;
    KeypairAccountResponseDTO? tronKeypair;

    if (responseModel.evmKeypair.publicKey != '' &&
        responseModel.evmKeypair.privateKey != '') {
      evmKeypair = KeypairAccountResponseDTO(
        blockchainIdentities: evmNetworks,
        publicKey: responseModel.evmKeypair.publicKey,
        privateKey: responseModel.evmKeypair.privateKey,
      );
    }
    if (responseModel.tronKeypair.publicKey != '' &&
        responseModel.tronKeypair.privateKey != '') {
      tronKeypair = KeypairAccountResponseDTO(
        blockchainIdentities: [BlockchainIdentity.tron],
        publicKey: responseModel.tronKeypair.publicKey,
        privateKey: responseModel.tronKeypair.privateKey,
      );
    }
    return GetAccountByMnemonicResponseEntity(
      isSuccess: isSuccess,
      evmKeypair: evmKeypair,
      tronKeypair: tronKeypair,
      errorMessage: errorMessage,
    );
  }

  static CreateMnemonicResponseEntity createMnemonicResponse({
    required bool isSuccess,
    required CreateMnemonicResponseModel responseModel,
    String? errorMessage,
  }) {
    String? mnemonic = responseModel.mnemonic;
    return CreateMnemonicResponseEntity(
      isSuccess: isSuccess,
      mnemonic: mnemonic,
      errorMessage: errorMessage,
    );
  }

  static CreateMnemonicAndAccountsResponseEntity
      createMnemonicAndAccountsResponse({
    required bool isSuccess,
    required CreateMnemonicAndAccountsResponseModel responseModel,
    String? errorMessage,
  }) {
    String? mnemonic = responseModel.mnemonic;
    KeypairAccountResponseDTO? evmKeypair;
    KeypairAccountResponseDTO? tronKeypair;

    if (responseModel.evmKeypair.publicKey != '' &&
        responseModel.evmKeypair.privateKey != '') {
      evmKeypair = KeypairAccountResponseDTO(
        blockchainIdentities: evmNetworks,
        publicKey: responseModel.evmKeypair.publicKey,
        privateKey: responseModel.evmKeypair.privateKey,
      );
    }
    if (responseModel.tronKeypair.publicKey != '' &&
        responseModel.tronKeypair.privateKey != '') {
      tronKeypair = KeypairAccountResponseDTO(
        blockchainIdentities: [BlockchainIdentity.tron],
        publicKey: responseModel.tronKeypair.publicKey,
        privateKey: responseModel.tronKeypair.privateKey,
      );
    }
    return CreateMnemonicAndAccountsResponseEntity(
      isSuccess: isSuccess,
      mnemonic: mnemonic,
      evmKeypair: evmKeypair,
      tronKeypair: tronKeypair,
      errorMessage: errorMessage,
    );
  }
}
