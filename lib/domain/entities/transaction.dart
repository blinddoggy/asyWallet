import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'transaction.g.dart';

@collection
class Transaction extends AbstractCollectibleEntity {
  final int? id;
  final String senderAddress;
  final String receiverAddress;
  final String blockchainNetworkName;
  final double amount;
  final DateTime timestamp;
  final int? accountId;
  final bool? isNative;
  final String? tokenAddress;

  Transaction({
    this.id,
    required this.senderAddress,
    required this.receiverAddress,
    required this.blockchainNetworkName,
    required this.amount,
    required this.timestamp,
    this.isNative,
    this.tokenAddress,
    this.accountId,
  });
}
