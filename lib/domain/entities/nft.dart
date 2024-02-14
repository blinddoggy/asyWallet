import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'nft.g.dart';

@collection
class NFT extends AbstractCollectibleEntity {
  final int id;
  final String name;
  final String description;
  final String owner;
  final String creator;
  final String image;
  @ignore
  final Map<String, dynamic>? metadata;

  NFT({
    required this.id,
    required this.name,
    required this.description,
    required this.creator,
    required this.owner,
    required this.image,
    this.metadata,
  });
}
