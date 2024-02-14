import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'wallet.g.dart';

@collection
class Wallet extends AbstractCollectibleEntity {
  final int id;
  final String? name;
  final String? address;

  final List<int> accountIds = [];
  final String networkId;

  Wallet({
    required this.id,
    required this.networkId,
    this.name,
    this.address,
  });
}
