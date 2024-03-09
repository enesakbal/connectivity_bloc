import 'dart:async';

import 'package:flutter/material.dart';

/// A utility class that helps in debouncing actions.
class Debouncer {
  final Duration duration;
  Timer? _timer;

  /// Creates a new instance of [Debouncer] with the specified [duration].
  Debouncer({required this.duration});

  /// Runs the specified [action] after the [duration] has elapsed.
  ///
  /// If this method is called multiple times within the [duration], the previous
  /// action will be canceled and the new action will be scheduled.
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}
