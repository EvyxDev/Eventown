class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {}

final class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}
