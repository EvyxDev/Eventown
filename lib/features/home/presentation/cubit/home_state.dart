import 'package:eventown/features/home/data/models/events_model/datum.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {}

final class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}

final class AddEventToWhishlistSuccess extends HomeState {
  AddEventToWhishlistSuccess(this.message);
  final String message;
}

final class AddEventToWhishlistFailed extends HomeState {
  AddEventToWhishlistFailed(this.message);
  final String message;
}

final class GetViewAllLoading extends HomeState {}

final class GetViewAllLoadingMore extends HomeState {}

final class GetViewAllSuccess extends HomeState {
  final List<EventModel> events;
  final bool hasMore;
  GetViewAllSuccess({required this.events, required this.hasMore});
}

final class GetViewAllError extends HomeState {
  GetViewAllError(this.message);
  final String message;
}
