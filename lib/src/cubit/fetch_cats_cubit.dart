import 'dart:developer';

import 'package:connectivity_bloc/core/models/cat_model.dart';
import 'package:connectivity_bloc/core/service/cat_service.dart';
import 'package:connectivity_bloc/src/connectivity/connectivity_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'fetch_cats_state.dart';

class FetchCatsCubit extends ConnectivityCubit<FetchCatsState> {
  FetchCatsCubit(this._catApiService) : super(const FetchCatsInitial());

  final List<CatModel> catList = [];

  Future<void> fetchCats() async {
    emit(const FetchCatsLoading());
    try {
      final result = await _catApiService.getCats();

      catList.addAll(result);
      emit(FetchCatsLoaded(catList));
    } on Exception catch (e) {
      emit(FetchCatsError(e.toString()));
    }
  }

  @override
  void onConnectivityChange(ConnectivityResult result) async {
    log('Connectivity changed: $result');

    if (result == ConnectivityResult.none) {
      emit(const FetchCatsNoInternet());
    }
  }

  final CatApiService _catApiService;
}
