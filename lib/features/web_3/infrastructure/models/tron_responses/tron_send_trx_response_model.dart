import 'dart:convert';

TronSendTrxResponseModel tronSendTrxResponseModelFromJson(String str) =>
    TronSendTrxResponseModel.fromJson(json.decode(str));

String tronSendTrxResponseModelToJson(TronSendTrxResponseModel data) =>
    json.encode(data.toJson());

class TronSendTrxResponseModel {
  final Result result;

  TronSendTrxResponseModel({
    required this.result,
  });

  TronSendTrxResponseModel copyWith({
    Result? result,
  }) =>
      TronSendTrxResponseModel(
        result: result ?? this.result,
      );

  factory TronSendTrxResponseModel.fromJson(Map<String, dynamic> json) =>
      TronSendTrxResponseModel(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class Result {
  final bool result;
  final String txid;
  final Transaction transaction;

  Result({
    required this.result,
    required this.txid,
    required this.transaction,
  });

  Result copyWith({
    bool? result,
    String? txid,
    Transaction? transaction,
  }) =>
      Result(
        result: result ?? this.result,
        txid: txid ?? this.txid,
        transaction: transaction ?? this.transaction,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        result: json["result"],
        txid: json["txid"],
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "txid": txid,
        "transaction": transaction.toJson(),
      };
}

class Transaction {
  final bool visible;
  final String txId;
  final String rawDataHex;
  final RawData rawData;
  final List<String> signature;

  Transaction({
    required this.visible,
    required this.txId,
    required this.rawDataHex,
    required this.rawData,
    required this.signature,
  });

  Transaction copyWith({
    bool? visible,
    String? txId,
    String? rawDataHex,
    RawData? rawData,
    List<String>? signature,
  }) =>
      Transaction(
        visible: visible ?? this.visible,
        txId: txId ?? this.txId,
        rawDataHex: rawDataHex ?? this.rawDataHex,
        rawData: rawData ?? this.rawData,
        signature: signature ?? this.signature,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        visible: json["visible"],
        txId: json["txID"],
        rawDataHex: json["raw_data_hex"],
        rawData: RawData.fromJson(json["raw_data"]),
        signature: List<String>.from(json["signature"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "visible": visible,
        "txID": txId,
        "raw_data_hex": rawDataHex,
        "raw_data": rawData.toJson(),
        "signature": List<dynamic>.from(signature.map((x) => x)),
      };
}

class RawData {
  final List<Contract> contract;
  final String refBlockBytes;
  final String refBlockHash;
  final int expiration;
  final int timestamp;

  RawData({
    required this.contract,
    required this.refBlockBytes,
    required this.refBlockHash,
    required this.expiration,
    required this.timestamp,
  });

  RawData copyWith({
    List<Contract>? contract,
    String? refBlockBytes,
    String? refBlockHash,
    int? expiration,
    int? timestamp,
  }) =>
      RawData(
        contract: contract ?? this.contract,
        refBlockBytes: refBlockBytes ?? this.refBlockBytes,
        refBlockHash: refBlockHash ?? this.refBlockHash,
        expiration: expiration ?? this.expiration,
        timestamp: timestamp ?? this.timestamp,
      );

  factory RawData.fromJson(Map<String, dynamic> json) => RawData(
        contract: List<Contract>.from(
            json["contract"].map((x) => Contract.fromJson(x))),
        refBlockBytes: json["ref_block_bytes"],
        refBlockHash: json["ref_block_hash"],
        expiration: json["expiration"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "contract": List<dynamic>.from(contract.map((x) => x.toJson())),
        "ref_block_bytes": refBlockBytes,
        "ref_block_hash": refBlockHash,
        "expiration": expiration,
        "timestamp": timestamp,
      };
}

class Contract {
  final Parameter parameter;
  final String type;

  Contract({
    required this.parameter,
    required this.type,
  });

  Contract copyWith({
    Parameter? parameter,
    String? type,
  }) =>
      Contract(
        parameter: parameter ?? this.parameter,
        type: type ?? this.type,
      );

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        parameter: Parameter.fromJson(json["parameter"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "parameter": parameter.toJson(),
        "type": type,
      };
}

class Parameter {
  final Value value;
  final String typeUrl;

  Parameter({
    required this.value,
    required this.typeUrl,
  });

  Parameter copyWith({
    Value? value,
    String? typeUrl,
  }) =>
      Parameter(
        value: value ?? this.value,
        typeUrl: typeUrl ?? this.typeUrl,
      );

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
        value: Value.fromJson(json["value"]),
        typeUrl: json["type_url"],
      );

  Map<String, dynamic> toJson() => {
        "value": value.toJson(),
        "type_url": typeUrl,
      };
}

class Value {
  final String toAddress;
  final String ownerAddress;
  final int amount;

  Value({
    required this.toAddress,
    required this.ownerAddress,
    required this.amount,
  });

  Value copyWith({
    String? toAddress,
    String? ownerAddress,
    int? amount,
  }) =>
      Value(
        toAddress: toAddress ?? this.toAddress,
        ownerAddress: ownerAddress ?? this.ownerAddress,
        amount: amount ?? this.amount,
      );

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        toAddress: json["to_address"],
        ownerAddress: json["owner_address"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "to_address": toAddress,
        "owner_address": ownerAddress,
        "amount": amount,
      };
}
