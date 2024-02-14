import 'package:tradex_wallet_3/domain/entities/_entities.dart' as entities;
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';
import 'package:tradex_wallet_3/domain/response_entities/_web_3_response_entities.dart';
import 'package:tradex_wallet_3/utils/utils.dart';
import 'package:tradex_wallet_3/features/web_3/domain/abstract_web_3.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/utils/abis.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

class Web3EthereumDatasourceImpl extends Web3Datasource {
  final Web3Client web3Client;

  Web3EthereumDatasourceImpl({required this.web3Client});

  @override
  Future<double> getNativeBalance(String accountAddress) async {
    final a = (await consultarSaldoNativo(accountAddress)).toDouble();
    return a;
  }

  @override
  Future<List<double>> getBalancesFromTokens(
      {required String publicKey,
      required String jsonRpc,
      required List<String> tokens}) async {
    try {
      final balances = (await consultarSaldoTokens(tokens, publicKey))
          .map((e) => e.toDouble())
          .toList();

      return balances;
    } catch (e) {
      return [];
    }
  }

  Future<BigInt> consultarSaldoNativo(String address) async {
    final balance =
        await web3Client.getBalance(EthereumAddress.fromHex(address));
    return balance.getInWei;
  }

  Future<List<BigInt>> consultarSaldoTokens(
      List<String> tokenAddresses, String userAddress) async {
    final List<BigInt> tokenBalances = [];

    for (final address in tokenAddresses) {
      final balance = await erc20Balance(userAddress, address);
      tokenBalances.add(balance);
    }

    return tokenBalances;
  }

  Future<BigInt> erc20Balance(String address, String addressToken) async {
    final contract = DeployedContract(
      ContractAbi.fromJson(json.encode(Abis.erc20Abi), 'ERC20'),
      EthereumAddress.fromHex(addressToken),
    );

    final balanceOfFunction = contract.function('balanceOf');
    final balance = await web3Client.call(
      contract: contract,
      function: balanceOfFunction,
      params: [EthereumAddress.fromHex(address)],
    );
    return balance.first;
  }

  @override
  Future<SendTransactionResponseEntity> sendTransaction({
    required String privateKey,
    required entities.Transaction transaction,
  }) async {
    final credentials = EthPrivateKey.fromHex(privateKey.toString());
    String? transactionHash;

    final amounInWei = Utils.double2Wei(transaction.amount);
    try {
      transactionHash = await enviarBalanceNativo(
          privateKey: credentials,
          recipientAddress: transaction.receiverAddress,
          value: amounInWei //amounInWei,
          );
    } catch (e) {
      return SendTransactionResponseEntity(
          isSuccess: false,
          transactionHash: transactionHash,
          // TODO: capturar error especifico y mostrarlo en pantalla.
          errorMessage: e.toString());
    }
    return SendTransactionResponseEntity(
        isSuccess: true, transactionHash: transactionHash);
  }

  Future<String> enviarBalanceNativo({
    required EthPrivateKey privateKey,
    required String recipientAddress,
    required BigInt value,
  }) async {
    final gasPrice = await getGasPrice();
    final xh = await web3Client.sendTransaction(
      privateKey,
      Transaction(
        to: EthereumAddress.fromHex(recipientAddress),
        gasPrice: EtherAmount.fromBigInt(EtherUnit.wei, gasPrice),
        maxGas: 300000,
        value: EtherAmount.fromBigInt(EtherUnit.wei, value),
      ),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );

    await web3Client.dispose();
    return (xh);
  }

  @override
  Future<BigInt> getGasPrice() async {
    try {
      final gasPrice = await web3Client.getGasPrice();
      return gasPrice.getInWei;
    } catch (e) {
      // TODO: agregar feedback del catch.
      // print('Error al obtener el precio del gas: $e');
    }
    await web3Client.dispose();
    return BigInt.from(0);
  }

  @override
  Future<List<BigInt>> getGasPriceEip1559() async {
    // TODO: Implementar la captura del gas con EIP1559.
    try {
      // final gasPrice = await web3Client.getGasInEIP1559();
    } catch (e) {
      // print('Error al obtener el precio del gas: $e');
    }
    await web3Client.dispose();
    throw UnimplementedError();
  }

  @override
  Future<SendTransactionResponseEntity> sendTokenTransaction({
    required String privateKey,
    required entities.Asset asset,
    required entities.Transaction transaction,
  }) async {
    String? transactionHash;

    final amount = Utils.fixAmountDecimalsFactorToBlockchain(
        transaction.amount, asset.decimals);
    try {
      if (transaction.tokenAddress == null) throw 'Missing token address.';
      transactionHash = await enviarERC20(
        senderPrivateKey: privateKey,
        senderAddress: transaction.senderAddress,
        recipientAddress: transaction.receiverAddress,
        tokenAddress: transaction.tokenAddress!,
        amount: BigInt.from(amount),
      );

      return SendTransactionResponseEntity(
          isSuccess: true, transactionHash: transactionHash);
    } catch (e) {
      return SendTransactionResponseEntity(
          isSuccess: false,
          transactionHash: transactionHash,
          // TODO: capturar error especifico y mostrarlo en pantalla.
          errorMessage: e.toString());
    }
  }

  @override
  Future<entities.Asset?> fetchTokenInfo({
    required BlockchainIdentity networkIdentity,
    required String addressToken,
  }) async {
    final contract = DeployedContract(
      ContractAbi.fromJson(json.encode(Abis.erc20Abi), 'ERC20'),
      EthereumAddress.fromHex(addressToken),
    );

    try {
      final futures = [
        callContractFunction(contract, 'name'),
        callContractFunction(contract, 'symbol'),
        callContractFunction(contract, 'decimals'),
      ];

      final results = await Future.wait(futures);

      final name = results[0].first;
      final symbol = results[1].first;
      final decimals = results[2].first;
      // TODO: Añadir aquí la lógica para obtener el icono
      return entities.Asset(
        blockchainNetworkIdentity: networkIdentity,
        address: addressToken,
        name: name,
        symbol: symbol,
        decimals: decimals.toInt(),
        balance: 0,
        icon: '',
      );
    } catch (e) {
      // TODO: agregar feedback del catch.
      return null;
    }
  }

  Future<List<dynamic>> callContractFunction(
      DeployedContract contract, String functionName) async {
    final result = await web3Client.call(
      contract: contract,
      function: contract.function(functionName),
      params: [],
    );
    return result;
  }

  Future<String> enviarERC20(
      {required String senderPrivateKey,
      required String senderAddress,
      required String recipientAddress,
      required String tokenAddress,
      required BigInt amount,
      int? maxGas,
      int? gasPrice}) async {
    final credentials = EthPrivateKey.fromHex(senderPrivateKey);
    final contract = DeployedContract(
      ContractAbi.fromJson(json.encode(Abis.erc20Abi), 'ERC20'),
      EthereumAddress.fromHex(tokenAddress),
    );

    final transactionFunction = contract.function('transfer');
    final transaction = Transaction.callContract(
      contract: contract,
      function: transactionFunction,
      parameters: [
        EthereumAddress.fromHex(recipientAddress),
        amount,
      ],
      from: EthereumAddress.fromHex(senderAddress),
      gasPrice: EtherAmount.fromInt(
        EtherUnit.gwei,
        gasPrice ?? 20,
      ),
      maxGas: maxGas ?? 100000,
    );

    final signedTransaction = await web3Client.signTransaction(
      credentials,
      transaction,
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );
    final response = await web3Client.sendRawTransaction(signedTransaction);
    return response;
  }
}
