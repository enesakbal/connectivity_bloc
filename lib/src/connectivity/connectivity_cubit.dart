import 'dart:async';

import 'package:connectivity_bloc/src/debouncer/debouncer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConnectivityCubit<State> extends BlocBase<State> {
  late final Connectivity _connectivity;
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityCubit(super.initialState) {
    _connectivity = Connectivity();
    final debouncer = Debouncer(duration: const Duration(milliseconds: 1500));
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      debouncer.run(() => onConnectivityChange.call(result));
    });
  }

  void onConnectivityChange(ConnectivityResult result);

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
