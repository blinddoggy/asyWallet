import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';
import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';

part 'asset.g.dart';

@collection
class Asset extends AbstractCollectibleEntity {
  int? id;
  @enumerated
  final BlockchainIdentity blockchainNetworkIdentity;
  final String name;
  final String address;
  final double balance;
  final String symbol;
  final int decimals;
  final String icon;

  Asset({
    this.id,
    required this.name,
    required this.address,
    required this.balance,
    required this.blockchainNetworkIdentity,
    required this.symbol,
    required this.decimals,
    required this.icon,
  });

  Asset copyWith({
    int? id,
    BlockchainIdentity? blockchainNetworkIdentity,
    String? name,
    String? address,
    double? balance,
    String? symbol,
    int? decimals,
    String? icon,
  }) {
    return Asset(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        balance: balance ?? this.balance,
        blockchainNetworkIdentity:
            blockchainNetworkIdentity ?? this.blockchainNetworkIdentity,
        symbol: symbol ?? this.symbol,
        decimals: decimals ?? this.decimals,
        icon: icon ?? this.icon);
  }
}
