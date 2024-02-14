import 'dart:convert';

CreateMnemonicResponseModel createMnemonicResponseModelFromJson(String str) =>
    CreateMnemonicResponseModel.fromJson(json.decode(str));

String createMnemonicResponseModelToJson(CreateMnemonicResponseModel data) =>
    json.encode(data.toJson());

class CreateMnemonicResponseModel {
  final String mnemonic;

  CreateMnemonicResponseModel({
    required this.mnemonic,
  });

  CreateMnemonicResponseModel copyWith({
    String? mnemonic,
  }) =>
      CreateMnemonicResponseModel(
        mnemonic: mnemonic ?? this.mnemonic,
      );

  factory CreateMnemonicResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateMnemonicResponseModel(
        mnemonic: json['mnemonic'],
      );

  Map<String, dynamic> toJson() => {
        'mnemonic': mnemonic,
      };
}
