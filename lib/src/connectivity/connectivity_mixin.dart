import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


mixin ListenConnectivity<T, E extends T> on BlocBase<T> {
  final List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> initConnectivity() async {
    try {
      _connectionStatus.clear();
      final result = await _connectivity.checkConnectivity();
      _connectionStatus.add(result);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void onChange(Change<T> change) {
    log('On change: $change');


    stream.listen((e) {
      log(e.toString());

      if (e is E) {
        log('No internet connection');
        emit(e);
        return;
      }

      log('Internet connection available');
    });

    // _stateController.stream.listen((event) {
    //   if (event is! T) {
    //     return;
    //   }

    //   if (_connectionStatus.contains(ConnectivityResult.none)) {
    //     log('No internet connection');
    //     return;
    //   }

    //   log('Internet connection available');
    // });
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
