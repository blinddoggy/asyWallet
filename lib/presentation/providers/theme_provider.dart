import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/config/theme/app_theme.dart';
import 'package:tradex_wallet_3/config/theme/custom_colors.dart';
import 'package:tradex_wallet_3/domain/entities/preferences.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
import 'package:tradex_wallet_3/features/storage/infrastructure/providers/local_storage_repositories_provider.dart';

final colorListProvider = Provider((ref) => CustomColors.colorList);

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier(ref));

class ThemeNotifier extends StateNotifier<AppTheme> {
  // ignore: unused_field
  final StateNotifierProviderRef<ThemeNotifier, AppTheme> _ref;

  final LocalStorageRepository<Preferences> _preferenceRepository;
  ThemeNotifier(this._ref)
      : _preferenceRepository =
            _ref.read(preferencesLocalStorageRepositoryProvider),
        super(AppTheme()) {
    loadThemePreferences();
  }

  void toggleDarkmode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
    saveThemePreferences();
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
    saveThemePreferences();
  }

  Future<void> loadThemePreferences() async {
    Preferences preferences =
        (await _preferenceRepository.getAll()).firstOrNull ?? Preferences();
    state = state.copyWith(
      isDarkmode: preferences.isDarkmode,
      selectedColor: preferences.selectedColor,
    );
    saveThemePreferences();
  }

  Future<void> saveThemePreferences() async {
    Preferences preferences =
        (await _preferenceRepository.getAll()).firstOrNull ?? Preferences();
    final prefs = preferences.copyWith(
      isDarkmode: state.isDarkmode,
      selectedColor: state.selectedColor,
    );
    await _preferenceRepository.save(prefs);
  }
}
