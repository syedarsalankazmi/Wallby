import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../configs/sharedPeferences.dart';

part 'theme_state.dart';

// Values are stored and updated here
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight(message: 'Dark Theme')) {
    AppSharedPrefernces().getNightMode().then((value) => {
          _isDark = value ?? false,
        });
  }

  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    AppSharedPrefernces().setNightMode(_isDark);
    if (_isDark) {
      emit(ThemeDark(message: 'Dark Theme'));
    } else {
      emit(ThemeLight(message: 'Light Theme'));
    }
  }
}
