import 'package:places/providers/theme_data_provider.dart';

class SettingsInteractor {
  final ThemeDataProvider darkModeProvider;

  SettingsInteractor({
    required this.darkModeProvider,
  });

  bool switchTheme({required bool value}) => darkModeProvider.switchTheme(value: value);
}
