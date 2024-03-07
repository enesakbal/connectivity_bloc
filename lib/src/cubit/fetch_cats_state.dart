part of 'fetch_cats_cubit.dart';

sealed class FetchCatsState extends Equatable {
  const FetchCatsState();

  @override
  List<Object> get props => [];
}

final class FetchCatsInitial extends FetchCatsState {
  const FetchCatsInitial();
}

final class FetchCatsLoading extends FetchCatsState {
  const FetchCatsLoading();
}

final class FetchCatsLoaded extends FetchCatsState {
  const FetchCatsLoaded(this.catList);

  final List<CatModel> catList;

  @override
  List<Object> get props => [catList];
}

final class FetchCatsError extends FetchCatsState {
  const FetchCatsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class FetchCatsNoInternet extends FetchCatsState {
  const FetchCatsNoInternet();
}
