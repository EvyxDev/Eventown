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

final class AddEventToCalenderSuccess extends HomeState {
  AddEventToCalenderSuccess(this.message);
  final String message;
}

final class AddEventToCalenderFailed extends HomeState {
  AddEventToCalenderFailed(this.message);
  final String message;
}

final class RemoveEventFromCalenderSuccess extends HomeState {
  RemoveEventFromCalenderSuccess(this.message);
  final String message;
}

final class RemoveEventFromCalenderFailed extends HomeState {
  RemoveEventFromCalenderFailed(this.message);
  final String message;
}

final class RemoveEventToWhishlistSuccess extends HomeState {
  RemoveEventToWhishlistSuccess(this.message);
  final String message;
}

final class RemoveEventToWhishlistFailed extends HomeState {
  RemoveEventToWhishlistFailed(this.message);
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

final class GetEventsByCategoryLoading extends HomeState {}

final class GetEventsByCategoryLoadingMore extends HomeState {}

final class GetEventsByCategorySuccess extends HomeState {
  final List<EventModel> events;
  final bool hasMore;
  GetEventsByCategorySuccess({required this.events, required this.hasMore});
}

final class GetEventsByCategoryError extends HomeState {
  GetEventsByCategoryError(this.message);
  final String message;
}

final class SearchEventsLoadingMore extends HomeState {}

final class SearchEventsLoading extends HomeState {}

final class SearchEventsSuccess extends HomeState {
  final List<EventModel> events;
  final bool hasMore;
  SearchEventsSuccess({required this.events, required this.hasMore});
}

final class SearchEventsError extends HomeState {
  SearchEventsError(this.message);
  final String message;
}

final class GetCalenderEventsLoading extends HomeState {}

final class GetCalenderEventsSuccess extends HomeState {
  GetCalenderEventsSuccess();
}

final class GetCalenderEventsError extends HomeState {
  GetCalenderEventsError(this.message);
  final String message;
}

final class GetEventByIdLoading extends HomeState {}

final class GetEventByIdSuccess extends HomeState {
  GetEventByIdSuccess();
}

final class GetEventByIdError extends HomeState {
  GetEventByIdError(this.message);
  final String message;
}

final class DeleteMyAccountLoading extends HomeState {}

final class DeleteMyAccountSuccess extends HomeState {}

final class DeleteMyAccountError extends HomeState {
  DeleteMyAccountError(this.message);
  final String message;
}

final class GetUserWishListLoading extends HomeState {}

final class GetUserWishListSuccess extends HomeState {}

final class GetUserWishListError extends HomeState {
  GetUserWishListError(this.message);
  final String message;
}

final class CreateEventLoading extends HomeState {}

final class CreateEventSuccess extends HomeState {}

final class CreateEventError extends HomeState {
  CreateEventError(this.message);
  final String message;
}

final class CreateCommentLoading extends HomeState {}

final class CreateCommentSuccess extends HomeState {}

final class CreateCommentError extends HomeState {
  CreateCommentError(this.message);
  final String message;
}
