import 'dart:convert';

TronInfoTrc20ResponseModel tronInfoTrc20ResponseModelFromJson(String str) =>
    TronInfoTrc20ResponseModel.fromJson(json.decode(str));

String tronInfoTrc20ResponseModelToJson(TronInfoTrc20ResponseModel data) =>
    json.encode(data.toJson());

class TronInfoTrc20ResponseModel {
  final String name;
  final int decimals;
  final String symbol;

  TronInfoTrc20ResponseModel({
    required this.name,
    required this.decimals,
    required this.symbol,
  });

  TronInfoTrc20ResponseModel copyWith({
    String? name,
    int? decimals,
    String? symbol,
  }) =>
      TronInfoTrc20ResponseModel(
        name: name ?? this.name,
        decimals: decimals ?? this.decimals,
        symbol: symbol ?? this.symbol,
      );

  factory TronInfoTrc20ResponseModel.fromJson(Map<String, dynamic> json) =>
      TronInfoTrc20ResponseModel(
        name: json["name"],
        decimals: json["decimals"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "decimals": decimals,
        "symbol": symbol,
      };
}
