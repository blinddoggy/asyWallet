// tokens.dart

import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:tradex_wallet_3/features/web_3/infrastructure/utils/abis.dart';

class TokensModel {
  final Web3Client client;
  List<String> tokenAddresses = [];
  List<String> tokenNames = [];
  List<String> blockchainsList = [];

  TokensModel(this.client);

  Future<List<BigInt>> infoTokensBalances(
      List<String> tokenAddresses, String userAddress) async {
    final List<BigInt> tokenBalances = [];

    for (final address in tokenAddresses) {
      final balance = await erc20Balance(userAddress, address);
      tokenBalances.add(balance);
    }

    return tokenBalances;
  }

  Future<List<String>> infoTokensNames(List<String> tokenAddresses) async {
    final List<String> tokenNames = [];

    for (final address in tokenAddresses) {
      final nombre = await obtenerNombreToken(address);
      tokenNames.add(nombre);
    }

    return tokenNames;
  }

  Future<void> removeTokenAddressFromStorage(int index) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // tokenAddresses = prefs.getStringList('token_addresses') ?? [];
    const prefs = null; // Reemplazar con SharedPreferences

    if (index >= 0 && index < tokenAddresses.length) {
      tokenAddresses.removeAt(index);
      await prefs.setStringList('token_addresses', tokenAddresses);
    }
  }

  Future<void> addTokenAddressToStorage(String tokenAddress) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // tokenAddresses = prefs.getStringList('token_addresses') ?? [];
    const prefs = null; // Reemplazar con SharedPreferences

    tokenAddresses.add(tokenAddress);
    await prefs.setStringList('token_addresses', tokenAddresses);
  }

  Future<void> loadTokenAddressesFromStorage() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // tokenAddresses = prefs.getStringList('token_addresses') ?? [];
    const prefs = null; // Reemplazar con SharedPreferences

    tokenAddresses = prefs.getStringList('token_addresses') ?? [];
  }

  Future<String> obtenerNombreToken(String tokenAddress) async {
    final contract = DeployedContract(
      ContractAbi.fromJson(json.encode(Abis.erc20Abi), 'ERC20'),
      EthereumAddress.fromHex(tokenAddress),
    );

    final nameFunction = contract.function('name');
    final nameResult = await client.call(
      contract: contract,
      function: nameFunction,
      params: [],
    );

    final nombre = nameResult[0].toString();

    return nombre;
  }

  Future<BigInt> consultarSaldoNativo(String address) async {
    final balance = await client.getBalance(EthereumAddress.fromHex(address));
    return balance.getInWei;
  }

  Future<BigInt> erc20Balance(String address, String addressToken) async {
    final contract = DeployedContract(
      ContractAbi.fromJson(json.encode(Abis.erc20Abi), 'ERC20'),
      EthereumAddress.fromHex(addressToken),
    );

    final balanceOfFunction = contract.function('balanceOf');
    final balance = await client.call(
      contract: contract,
      function: balanceOfFunction,
      params: [EthereumAddress.fromHex(address)],
    );
    return balance.first;
  }
}
