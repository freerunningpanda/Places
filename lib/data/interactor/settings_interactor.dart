import 'package:places/providers/dark_mode_provider.dart';

class SettingsInteractor {
  final DarkModeProvider darkModeProvider;

  SettingsInteractor({
    required this.darkModeProvider,
  });

  bool switchTheme({required bool value}) => darkModeProvider.switchTheme(value: value);
}
