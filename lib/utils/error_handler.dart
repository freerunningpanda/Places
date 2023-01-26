import 'package:flutter/foundation.dart';
import 'package:mwwm/mwwm.dart';

class StandartErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('Handled error: $e');
  }
}
