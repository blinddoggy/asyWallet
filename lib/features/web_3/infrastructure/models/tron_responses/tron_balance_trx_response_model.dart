import 'dart:convert';

TronBalanceTrxResponseModel tronBalanceTrxResponseModelFromJson(String str) =>
    TronBalanceTrxResponseModel.fromJson(json.decode(str));

String tronBalanceTrxResponseModelToJson(TronBalanceTrxResponseModel data) =>
    json.encode(data.toJson());

class TronBalanceTrxResponseModel {
  final double balanceTrc20;

  TronBalanceTrxResponseModel({
    required this.balanceTrc20,
  });

  TronBalanceTrxResponseModel copyWith({
    double? balanceTrc20,
  }) =>
      TronBalanceTrxResponseModel(
          balanceTrc20: balanceTrc20 ?? this.balanceTrc20);

  factory TronBalanceTrxResponseModel.fromJson(Map<String, dynamic> json) =>
      TronBalanceTrxResponseModel(
        balanceTrc20: json['balanceTrc20']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {'balanceTrc20': balanceTrc20};
}
