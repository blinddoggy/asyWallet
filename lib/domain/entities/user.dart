import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'user.g.dart';

@collection
class User extends AbstractCollectibleEntity {
  final int id;
  final String name;
  final String email;
  final String pin;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.pin,
    required this.phoneNumber,
  });
}
