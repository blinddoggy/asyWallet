import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'preferences.g.dart';

@collection
class Preferences extends AbstractCollectibleEntity {
  bool isDarkmode;
  int selectedColor;
  String pinHash;
  String mnemonicHash;
  Preferences({
    super.isarId = 1,
    this.isDarkmode = false,
    this.pinHash = '',
    this.mnemonicHash = '',
    this.selectedColor = 0,
  });

  copyWith({
    bool? isDarkmode,
    int? selectedColor,
    String? pinHash,
    String? mnemonicHash,
  }) {
    return Preferences(
      isDarkmode: isDarkmode ?? this.isDarkmode,
      selectedColor: selectedColor ?? this.selectedColor,
      pinHash: pinHash ?? this.pinHash,
      mnemonicHash: mnemonicHash ?? this.mnemonicHash,
    );
  }
}
