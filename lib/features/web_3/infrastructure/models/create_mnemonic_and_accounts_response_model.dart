import 'dart:convert';

CreateMnemonicAndAccountsResponseModel getAccountsResponseModelFromJson(
        String str) =>
    CreateMnemonicAndAccountsResponseModel.fromJson(json.decode(str));

String getAccountsResponseModelToJson(
        CreateMnemonicAndAccountsResponseModel data) =>
    json.encode(data.toJson());

class CreateMnemonicAndAccountsResponseModel {
  final String mnemonic;
  final Keypair evmKeypair;
  final Keypair tronKeypair;

  CreateMnemonicAndAccountsResponseModel({
    required this.mnemonic,
    required this.evmKeypair,
    required this.tronKeypair,
  });

  CreateMnemonicAndAccountsResponseModel copyWith({
    String? mnemonic,
    Keypair? evmKeypair,
    Keypair? tronKeypair,
  }) =>
      CreateMnemonicAndAccountsResponseModel(
        mnemonic: mnemonic ?? this.mnemonic,
        evmKeypair: evmKeypair ?? this.evmKeypair,
        tronKeypair: tronKeypair ?? this.tronKeypair,
      );

  factory CreateMnemonicAndAccountsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CreateMnemonicAndAccountsResponseModel(
        mnemonic: json["mnemonic"],
        evmKeypair: Keypair.fromJson(json["evm_keypair"]),
        tronKeypair: Keypair.fromJson(json["tron_keypair"]),
      );

  Map<String, dynamic> toJson() => {
        "mnemonic": mnemonic,
        "evm_keypair": evmKeypair.toJson(),
        "tron_keypair": tronKeypair.toJson(),
      };
}

class Keypair {
  final String publicKey;
  final String privateKey;

  Keypair({
    required this.publicKey,
    required this.privateKey,
  });

  Keypair copyWith({
    String? publicKey,
    String? privateKey,
  }) =>
      Keypair(
        publicKey: publicKey ?? this.publicKey,
        privateKey: privateKey ?? this.privateKey,
      );

  factory Keypair.fromJson(Map<String, dynamic> json) => Keypair(
        publicKey: json["public_key"],
        privateKey: json["private_key"],
      );

  Map<String, dynamic> toJson() => {
        "public_key": publicKey,
        "private_key": privateKey,
      };
}
