import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'notification.g.dart';

@collection
class Notification extends AbstractCollectibleEntity {
  final int id;
  final String message;
  final DateTime timestamp;
  final bool read;

  Notification({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.read,
  });
}
