import 'dart:convert';

TronSendTrc20ResponseModel tronSendTrc20ResponseModelFromJson(String str) =>
    TronSendTrc20ResponseModel.fromJson(json.decode(str));

String tronSendTrc20ResponseModelToJson(TronSendTrc20ResponseModel data) =>
    json.encode(data.toJson());

class TronSendTrc20ResponseModel {
  final String result;

  TronSendTrc20ResponseModel({
    required this.result,
  });

  TronSendTrc20ResponseModel copyWith({
    String? result,
  }) =>
      TronSendTrc20ResponseModel(
        result: result ?? this.result,
      );

  factory TronSendTrc20ResponseModel.fromJson(Map<String, dynamic> json) =>
      TronSendTrc20ResponseModel(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
