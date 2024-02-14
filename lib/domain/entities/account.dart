import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'account.g.dart';

@collection
class Account extends AbstractCollectibleEntity {
  final String name;
  final String address;
  final String privateKey;
  @enumerated
  final List<BlockchainIdentity> blockchainNetworks;

  Account({
    required this.name,
    required this.address,
    required this.privateKey,
    required this.blockchainNetworks,
  });

  copyWith({
    name,
    address,
    privateKey,
    blockchainNetworks,
  }) {
    return Account(
      name: name ?? this.name,
      address: address ?? this.address,
      privateKey: privateKey ?? this.privateKey,
      blockchainNetworks: blockchainNetworks ?? this.blockchainNetworks,
    );
  }
}
