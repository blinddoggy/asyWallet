import 'dart:convert';

TronBalanceTrc20ResponseModel tronBalanceTrc20ResponseModelFromJson(
        String str) =>
    TronBalanceTrc20ResponseModel.fromJson(json.decode(str));

String tronBalanceTrc20ResponseModelToJson(
        TronBalanceTrc20ResponseModel data) =>
    json.encode(data.toJson());

class TronBalanceTrc20ResponseModel {
  final double balance;

  TronBalanceTrc20ResponseModel({
    required this.balance,
  });

  TronBalanceTrc20ResponseModel copyWith({
    double? balance,
  }) =>
      TronBalanceTrc20ResponseModel(
        balance: balance ?? this.balance,
      );

  factory TronBalanceTrc20ResponseModel.fromJson(Map<String, dynamic> json) =>
      TronBalanceTrc20ResponseModel(
        balance: json['balance']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'balance': balance,
      };
}
