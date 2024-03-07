import 'package:connectivity_bloc/core/models/cat_model.dart';
import 'package:connectivity_bloc/core/service/cat_service.dart';
import 'package:connectivity_bloc/src/connectivity/connectivity_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_cats_state.dart';

class FetchCatsCubit extends Cubit<FetchCatsState> with ListenConnectivity<FetchCatsState, FetchCatsError> {
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

  final CatApiService _catApiService;
}
