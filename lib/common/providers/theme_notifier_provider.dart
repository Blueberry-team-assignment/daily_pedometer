part of 'provider.dart';

@riverpod
class ThemeNotifierProvider extends _$ThemeNotifierProvider {
  @override
  ThemeMode build() {
    _loadThemeMode();
    return state;
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      saveThemeMode(state);
    } else {
      state = ThemeMode.light;
      saveThemeMode(state);
    }
  }

  Future<void> _loadThemeMode() async {
    final storage = ref.watch(storageProvider);
    final themeIndex = await storage.get(key: themeMode) ?? "1";
    state = ThemeMode.values[int.tryParse(themeIndex.toString()) ?? 1];
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final storage = ref.watch(storageProvider);
    await storage.set(key: themeMode, data: mode.index);
  }
}
