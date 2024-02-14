import 'dart:convert';

GetAccountsByMnemonicResponseModel getAccountsByMnemonicResponseModelFromJson(
        String str) =>
    GetAccountsByMnemonicResponseModel.fromJson(json.decode(str));

String getAccountsByMnemonicResponseModelToJson(
        GetAccountsByMnemonicResponseModel data) =>
    json.encode(data.toJson());

class GetAccountsByMnemonicResponseModel {
  final Keypair evmKeypair;
  final Keypair tronKeypair;

  GetAccountsByMnemonicResponseModel({
    required this.evmKeypair,
    required this.tronKeypair,
  });

  GetAccountsByMnemonicResponseModel copyWith({
    Keypair? evmKeypair,
    Keypair? tronKeypair,
  }) =>
      GetAccountsByMnemonicResponseModel(
        evmKeypair: evmKeypair ?? this.evmKeypair,
        tronKeypair: tronKeypair ?? this.tronKeypair,
      );

  factory GetAccountsByMnemonicResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAccountsByMnemonicResponseModel(
        evmKeypair: Keypair.fromJson(json["evm_keypair"]),
        tronKeypair: Keypair.fromJson(json["tron_keypair"]),
      );

  Map<String, dynamic> toJson() => {
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
