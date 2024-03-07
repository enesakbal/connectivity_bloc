import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConnectivityCubit<State> extends BlocBase<State> {
  late final Connectivity _connectivity;
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityCubit(super.initialState) {
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(onConnectivityChange);
  }

  void onConnectivityChange(ConnectivityResult result);

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  Future<void> initConnectivity() async {
    _connectivity = Connectivity();

    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      // _isInitialised = true;
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    onConnectivityChange(result);
    return;
  }
}
