import 'package:dartz/dartz.dart';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/events_model.dart';
import 'package:eventown/features/home/data/repositories/home_repo.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
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
  addEventToWishlist(context, {required EventModel event}) async {
    wishlistEventsIds.add(event.id ?? "");
    // wishListEvents.add(event);
    emit(HomeInitial());
    final response = await homeRepo.addEventToWishlist(event.id ?? "");
    response.fold(
      (l) {
        wishlistEventsIds.remove(event.id ?? "");
        // wishListEvents.remove(event);
        showTwist(
          context: context,
          messege: AppStrings.couldNotAddToWishList.tr(context),
        );
        emit(AddEventToWhishlistFailed(l));
      },
      (r) {
        showTwist(
          context: context,
          messege: AppStrings.addedToWishList.tr(context),
        );
        emit(AddEventToWhishlistSuccess(r));
      },
    );
  }

  //! Remove Event From Wishlist
  removeEventFromWishlist(context, {required EventModel event}) async {
    wishlistEventsIds.remove(event.id ?? "");
    // wishListEvents.remove(event);
    emit(HomeInitial());
    final response = await homeRepo.removeEventFromWishlist(event.id ?? "");
    response.fold(
      (l) {
        wishlistEventsIds.add(event.id ?? "");
        // wishListEvents.add(event);
        showTwist(
          context: context,
          messege: AppStrings.couldNotRemoveFromWishList.tr(context),
        );
        emit(RemoveEventToWhishlistFailed(l));
      },
      (r) {
        showTwist(
          context: context,
          messege: AppStrings.removedFromWishList.tr(context),
        );
        emit(RemoveEventToWhishlistSuccess(r));
      },
    );
  }

  //! Get Wishlist Events
  List<String> wishlistEventsIds = [];
  List<EventModel> wishListEvents = [];
  getWishlistEvents({bool isLoading = false}) async {
    if (isLoading) emit(GetUserWishListLoading());
    final response = await homeRepo.fetchWishlistEvents();
    response.fold(
      (l) {
        if (isLoading) emit(GetUserWishListError(l));
      },
      (r) {
        wishlistEventsIds = r.data?.map((e) => e.id ?? '').toList() ?? [];
        wishListEvents = r.data ?? [];
        if (isLoading) emit(GetUserWishListSuccess());
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
      return; //? Exit if no more events are available
    }

    if (loadMore) {
      isLoadingMore = true;
      emit(GetViewAllLoadingMore());
      currentPage++; //? Increase page number for loading more
    } else {
      emit(GetViewAllLoading());
      currentPage = 1; //? Reset page for fresh data load
      viewAllEvents = []; //? Clear the list when starting fresh
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

  //! Get Event By Id
  EventModel? eventById;
  getEventById(String eventId) async {
    emit(GetEventByIdLoading());
    final response = await homeRepo.fetchEventDetails(eventId);
    response.fold(
      (l) {
        emit(GetEventByIdError(l));
      },
      (r) {
        eventById = r;
        emit(GetEventByIdSuccess());
      },
    );
  }

  //! Search and Filter Events
  int searchCurrentPage = 1;
  int searchLimit = 4;
  bool searchHasMoreEvents = true;
  bool searchIsLoadingMore = false;
  List<EventModel> searchEvents = [];
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  //! Update Start and End Date
  DateTime? startDate;
  DateTime? endDate;
  updateStartAndEndData(DateTime? start, DateTime? end) {
    startDate = start;
    endDate = end;
    emit(HomeInitial());
  }

  //! Update Selected Category
  String? selectedCategoryId;
  updateSelectedCategoryId(String? categoryId) {
    selectedCategoryId = categoryId;
    emit(HomeInitial());
  }

  //! Sort By Price (Low to High)
  bool isSortByPriceLowToHigh = false;
  sortByPriceLowToHigh() {
    isSortByPriceLowToHigh = !isSortByPriceLowToHigh;
    emit(HomeInitial());
  }

  //! search Events By Query And Filter
  Future<void> searchEventsByQuery({
    bool loadMore = false,
  }) async {
    if (loadMore && !searchHasMoreEvents) {
      return; //? Exit if no more events are available
    }

    if (loadMore) {
      searchIsLoadingMore = true;
      emit(SearchEventsLoadingMore());
      searchCurrentPage++; //? Increase page number for loading more
    } else {
      emit(SearchEventsLoading());
      searchCurrentPage = 1; //? Reset page for fresh data load
      searchEvents = []; //? Clear the list when starting fresh
    }

    Either<String, EventsModel> response;

    response = await homeRepo.searchEvents(
      limit: searchLimit,
      page: searchCurrentPage,
      query: searchController.text,
      startDate: startDate?.toString(),
      endDate: endDate?.toString(),
      eventCategory: selectedCategoryId,
      isSortByPrice: isSortByPriceLowToHigh,
    );

    response.fold(
      (fail) {
        emit(SearchEventsError('Error: $fail'));
      },
      (success) {
        List<EventModel> newEvents = success.data ?? [];
        searchEvents.addAll(newEvents); //? Append new events
        //? Check if more data can be loaded
        searchHasMoreEvents = newEvents.length == searchLimit;
        //? Emit success with updated events and hasMore flag
        emit(SearchEventsSuccess(
            events: searchEvents, hasMore: searchHasMoreEvents));
      },
    );
  }

  //!is filters applied
  bool isFiltersApplied() {
    return startDate == null &&
        endDate == null &&
        selectedCategoryId == null &&
        isSortByPriceLowToHigh == false;
  }

  //! Get User Calender
  List<EventModel> userCalender = [];
  List<String> userCalenmderIds = [];
  getUserCalender() async {
    emit(GetCalenderEventsLoading());
    final response = await homeRepo.fetchCalendarEvents();
    response.fold(
      (l) {
        emit(GetCalenderEventsError(l));
      },
      (r) {
        userCalender = r.data ?? [];
        userCalenmderIds = r.data?.map((e) => e.id ?? '').toList() ?? [];
        emit(GetCalenderEventsSuccess());
      },
    );
  }

  //! Add Event to Calender
  addEventToCalender({required EventModel event}) async {
    userCalenmderIds.add(event.id ?? "");

    emit(HomeInitial());
    final response = await homeRepo.addEventToCalendar(event.id ?? "");
    response.fold(
      (l) {
        userCalenmderIds.remove(event.id ?? "");
        emit(AddEventToCalenderFailed(l));
      },
      (r) {
        emit(AddEventToCalenderSuccess(r));
      },
    );
  }

  //! Remove Event from Calender
  removeEventFromCalender({required EventModel event}) async {
    userCalenmderIds.remove(event.id ?? "");
    emit(HomeInitial());
    final response = await homeRepo.removeEventFromCalendar(event.id ?? "");
    response.fold(
      (l) {
        userCalenmderIds.add(event.id ?? "");
        emit(RemoveEventFromCalenderFailed(l));
      },
      (r) {
        emit(RemoveEventFromCalenderSuccess(r));
      },
    );
  }

  //! Is Event In Calender
  isEventInCalender(String eventId) {
    return userCalenmderIds.contains(eventId);
  }

  //delete My Account
  deleteMyAccount() async {
    emit(DeleteMyAccountLoading());
    final response = await homeRepo.deleteMyAccount();
    response.fold(
      (l) {
        emit(DeleteMyAccountError(l));
      },
      (r) {
        emit(DeleteMyAccountSuccess());
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
