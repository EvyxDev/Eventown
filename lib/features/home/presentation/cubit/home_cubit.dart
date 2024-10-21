import 'package:dartz/dartz.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/events_model.dart';
import 'package:eventown/features/home/data/repositories/home_repo.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;

  //! Get Home Data
  void getHomeData() async {
    emit(HomeLoading());
    await getWishlistEvents();
    await getHomeCategories();
    await getTopEvents();
    await getOnThisWeekEvents();
    await getForYouEvents();
    await getInYourAreaEvents();
    emit(HomeLoaded());
  }

  //! Home Categories
  List<Category> homeCategories = [];
  getHomeCategories() async {
    final response = await homeRepo.fetchHomeCategories();
    response.fold(
      (l) {},
      (r) {
        homeCategories = r.data ?? [];
      },
    );
  }

  //! Top Events
  List<EventModel> topEvents = [];
  getTopEvents() async {
    final response = await homeRepo.fetchHomeTopEvents(limit: 4);
    response.fold(
      (l) {},
      (r) {
        topEvents = r.data ?? [];
      },
    );
  }

  //! On This Week Events
  List<EventModel> onThisWeekEvents = [];
  getOnThisWeekEvents() async {
    final response = await homeRepo.fetchHomeOnThisWeekEvents(limit: 4);
    response.fold(
      (l) {},
      (r) {
        onThisWeekEvents = r.data ?? [];
      },
    );
  }

  //! For You Events
  List<EventModel> forYouEvents = [];
  getForYouEvents() async {
    final response = await homeRepo.fetchHomeForYouEvents(limit: 4);
    response.fold(
      (l) {},
      (r) {
        forYouEvents = r.data ?? [];
      },
    );
  }

  //! In Your Area Events
  List<EventModel> inYourAreaEvents = [];
  getInYourAreaEvents() async {
    final response = await homeRepo.fetchHomeInYourAreaEvents(limit: 4);
    response.fold(
      (l) {},
      (r) {
        inYourAreaEvents = r.data ?? [];
      },
    );
  }

  //! Get All Events
  List<EventModel> allEvents = [];
  getAllEvents() async {
    final response = await homeRepo.fetchAllEvents();
    response.fold(
      (l) {},
      (r) {
        allEvents = r.data ?? [];
      },
    );
  }

  //! Add Event To Wishlist
  addEventToWishlist({required String eventId}) async {
    wishlistEventsIds.add(eventId);
    emit(HomeInitial());
    final response = await homeRepo.addEventToWishlist(eventId);
    response.fold(
      (l) {
        wishlistEventsIds.remove(eventId);
        emit(AddEventToWhishlistFailed(l));
      },
      (r) {
        emit(AddEventToWhishlistSuccess(r));
      },
    );
  }

  //! Remove Event From Wishlist
  removeEventFromWishlist({required String eventId}) async {
    wishlistEventsIds.remove(eventId);
    emit(HomeInitial());
    final response = await homeRepo.removeEventFromWishlist(eventId);
    response.fold(
      (l) {
        wishlistEventsIds.add(eventId);
        emit(RemoveEventToWhishlistFailed(l));
      },
      (r) {
        emit(RemoveEventToWhishlistSuccess(r));
      },
    );
  }

  //! Get Wishlist Events
  List<String> wishlistEventsIds = [];
  getWishlistEvents() async {
    final response = await homeRepo.fetchWishlistEvents();
    response.fold(
      (l) {},
      (r) {
        wishlistEventsIds = r.data?.map((e) => e.id ?? '').toList() ?? [];
      },
    );
  }

  //! Check Event is in Wishlist
  bool isEventInWishlist(String eventId) {
    return wishlistEventsIds.contains(eventId);
  }

  //! View All Events
  int currentPage = 1;
  int limit = 4;
  bool hasMoreEvents = true;
  bool isLoadingMore = false;
  List<EventModel> viewAllEvents = [];
  Future<void> getViewAllEvents({
    bool loadMore = false,
    required EventsType type,
  }) async {
    if (loadMore && !hasMoreEvents) {
      return; // Exit if no more events are available
    }

    if (loadMore) {
      isLoadingMore = true;
      emit(GetViewAllLoadingMore());
      currentPage++; // Increase page number for loading more
    } else {
      emit(GetViewAllLoading());
      currentPage = 1; // Reset page for fresh data load
      viewAllEvents = []; // Clear the list when starting fresh
    }

    Either<String, EventsModel> response;
    switch (type) {
      case EventsType.topEvents:
        response = await homeRepo.fetchHomeTopEvents(
          limit: limit,
          page: currentPage,
        );
        break;
      case EventsType.onThisWeek:
        response = await homeRepo.fetchHomeOnThisWeekEvents(
          limit: limit,
          page: currentPage,
        );
        break;
      case EventsType.forYou:
        response = await homeRepo.fetchHomeForYouEvents(
          limit: limit,
          page: currentPage,
        );
        break;
      case EventsType.inYourArea:
        response = await homeRepo.fetchHomeInYourAreaEvents(
          limit: limit,
          page: currentPage,
        );
        break;
    }

    response.fold(
      (fail) {
        emit(GetViewAllError('Error: $fail'));
      },
      (success) {
        List<EventModel> newEvents = success.data ?? [];
        viewAllEvents.addAll(newEvents); // Append new events
        // Check if more data can be loaded
        hasMoreEvents = newEvents.length == limit;
        // Emit success with updated events and hasMore flag
        emit(GetViewAllSuccess(events: viewAllEvents, hasMore: hasMoreEvents));
      },
    );
  }

  //! Get Events By Category with Pagination
  int categoryCurrentPage = 1;
  int categoryLimit = 4;
  bool categoryHasMoreEvents = true;
  bool categoryIsLoadingMore = false;
  List<EventModel> eventsByCategory = [];
  Future<void> getEventsByCategory({
    bool loadMore = false,
    required String categoryId,
  }) async {
    if (loadMore && !categoryHasMoreEvents) {
      return; // Exit if no more events are available
    }

    if (loadMore) {
      categoryIsLoadingMore = true;
      emit(GetEventsByCategoryLoadingMore());
      categoryCurrentPage++; // Increase page number for loading more
    } else {
      emit(GetEventsByCategoryLoading());
      categoryCurrentPage = 1; // Reset page for fresh data load
      eventsByCategory = []; // Clear the list when starting fresh
    }

    Either<String, EventsModel> response;

    response = await homeRepo.fetchEventsByCategory(
      limit: categoryLimit,
      page: categoryCurrentPage,
      categoryId: categoryId,
    );

    response.fold(
      (fail) {
        emit(GetEventsByCategoryError('Error: $fail'));
      },
      (success) {
        List<EventModel> newEvents = success.data ?? [];
        eventsByCategory.addAll(newEvents); // Append new events
        // Check if more data can be loaded
        categoryHasMoreEvents = newEvents.length == categoryLimit;
        // Emit success with updated events and hasMore flag
        emit(GetEventsByCategorySuccess(
            events: eventsByCategory, hasMore: categoryHasMoreEvents));
      },
    );
  }
}

enum EventsType {
  topEvents,
  onThisWeek,
  forYou,
  inYourArea,
}
