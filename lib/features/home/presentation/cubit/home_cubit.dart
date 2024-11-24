import 'package:dartz/dartz.dart';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/common/logs.dart';
import 'package:eventown/core/locale/app_loacl.dart';
import 'package:eventown/core/utils/app_strings.dart.dart';
import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/events_model.dart';
import 'package:eventown/features/home/data/models/wish_list_model/comment.dart';
import 'package:eventown/features/home/data/models/wish_list_model/user.dart';
import 'package:eventown/features/home/data/repositories/home_repo.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);

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

  //! Wheel Promotions
  final List<Map<String, dynamic>> wheelPromotions = [
    {
      "title": "Spin & Win: Your Ticket to Any Event! 🎟",
      "description":
          "Are you feeling lucky? Try it now and win big with Evntown! 🎉",
    },
    {
      "title": "Unleash your luck with Evntown’s Lucky Ticket Spin! 🎡",
      "description":
          "Spin the wheel once a day, collect points, and get closer to winning a free ticket to your dream event. Reach 1,000 points, and you’re in! Simply submit your points for a chance to win. 🌟",
    },
    {
      "title": "✨ How It Works",
      "description":
          "Daily Spin: Earn points with each spin! Collect 1,000 Points: Once you hit 1,000, submit a request to enter the monthly draw.\nChoose Your Event: Pick up to 3 events you’d love to attend!",
    },
  ];

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
          query: searchController.text,
          startDate: startDate?.toString(),
          endDate: endDate?.toString(),
          eventCategory: selectedCategoryId,
          isSortByPrice: isSortByPriceLowToHigh,
        );
        break;
      case EventsType.onThisWeek:
        response = await homeRepo.fetchHomeOnThisWeekEvents(
          limit: limit,
          page: currentPage,
          query: searchController.text,
          startDate: startDate?.toString(),
          endDate: endDate?.toString(),
          eventCategory: selectedCategoryId,
          isSortByPrice: isSortByPriceLowToHigh,
        );
        break;
      case EventsType.forYou:
        response = await homeRepo.fetchHomeForYouEvents(
          limit: limit,
          page: currentPage,
          query: searchController.text,
          startDate: startDate?.toString(),
          endDate: endDate?.toString(),
          eventCategory: selectedCategoryId,
          isSortByPrice: isSortByPriceLowToHigh,
        );
        break;
      case EventsType.inYourArea:
        response = await homeRepo.fetchHomeInYourAreaEvents(
          limit: limit,
          page: currentPage,
          query: searchController.text,
          startDate: startDate?.toString(),
          endDate: endDate?.toString(),
          eventCategory: selectedCategoryId,
          isSortByPrice: isSortByPriceLowToHigh,
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
  List<Comment> eventByIdComments = [];
  getEventById(String eventId) async {
    emit(GetEventByIdLoading());
    final response = await homeRepo.fetchEventDetails(eventId);
    response.fold(
      (l) {
        emit(GetEventByIdError(l));
      },
      (r) {
        eventById = r;
        eventByIdComments = r.comments ?? [];
        emit(GetEventByIdSuccess());
      },
    );
  }

  //!Create Comment
  final TextEditingController commentController = TextEditingController();
  createComment(String eventId, String name) async {
    final comment = Comment(
      id: generateRandomString(15),
      user: User(
        name: name,
      ),
      text: commentController.text.trim(),
    );
    eventByIdComments.insert(0, comment);
    emit(CreateCommentLoading());
    final response = await homeRepo.createComment(
      eventId: eventId,
      comment: commentController.text.trim(),
    );
    response.fold(
      (fail) {
        eventByIdComments.remove(comment);
        emit(CreateCommentError(fail));
      },
      (success) {
        emit(CreateCommentSuccess());
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

  //! selected City
  String? selectedCity;
  updateSelectedCity(String city) {
    selectedCity = city;
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
      selectedCity: selectedCity,
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

  //! Clear Filters
  clearFilters() {
    startDate = null;
    endDate = null;
    selectedCategoryId = null;
    isSortByPriceLowToHigh = false;
    selectedCity = null;
    emit(HomeInitial());
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

  //! Delete My Account
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

  //! Create Event

  XFile? eventImage;
  updateEventImage(XFile image) {
    eventImage = image;
    emit(HomeInitial());
  }

  String? selectedCityCreateEvent;
  updateSelectedCityCreateEvent(String city) {
    selectedCityCreateEvent = city;
    emit(HomeInitial());
  }

  String? selectedCategoryIdCreateEvent;
  updateSelectedCategoryIdCreateEvent(String id) {
    selectedCategoryIdCreateEvent = id;
    emit(HomeInitial());
  }



  List<Map<String, dynamic>> plans = [
    {
      "planName": "free",
      "price": 0,
      "features": [
        "The event is published in the app after review and approval.",
      ],
      "duration": null, // No duration for Free Plan
    },
    {
      "planName": "basic",
      "price": 10,
      "features": [
        "Featured Listing: Event is listed in the 'Top Events' for easy discovery.",
        "Custom Notification: One notification sent to users with similar interests.",
        "Social Media Shoutout: One post on Evntown's social media channels.",
      ],
      "duration": "5 days",
    },
    {
      "planName": "standard",
      "price": 20,
      "features": [
        "Higher Visibility: Event is prominently featured in the 'Top Events' list.",
        "Targeted Notifications: 3 custom notifications sent to a curated user list.",
        "Social Media Campaign: 3 dedicated posts on Evntown's social media platforms.",
        "Event Analytics: Basic report on user interactions and views.",
      ],
      "duration": "10 days",
    },
    {
      "planName": "premium",
      "price": 25,
      "features": [
        "Prominent Listing: Featured in the 'Top Events' for maximum exposure.",
        "Multiple Notifications: Up to 5 custom notifications to reach more users.",
        "Comprehensive Social Media Campaign: 5 posts across all platforms, including boosted ads.",
        "Advanced Analytics: Real-time tracking and detailed post-event analysis.",
        "Newsletter Feature: Highlighted in the weekly Evntown newsletter.",
      ],
      "duration": "15 days",
    },
  ];
  String? selectedorganizerPlan = "free";
  updateSelectedOrganizerPlan(String plane) {
    selectedorganizerPlan = plane;
    emit(HomeInitial());
  }

  DateTime? selectedEventDateCreateEvent;
  updateSelectedEventDateCreateEvent(DateTime date) {
    selectedEventDateCreateEvent = date;
    emit(HomeInitial());
  }

  DateTime? selectedStartTimeCreateEvent;
  updateSelectedStarttime(DateTime time) {
    selectedStartTimeCreateEvent = time;
    emit(HomeInitial());
  }

  DateTime? selectedEndTimeCreateEvent;
  updateSelectedEndtime(DateTime time) {
    selectedEndTimeCreateEvent = time;
    emit(HomeInitial());
  }

  clearDate() {
    eventImage = null;
    selectedCityCreateEvent = null;
    selectedCategoryIdCreateEvent = null;
    selectedorganizerPlan = null;
    selectedEventDateCreateEvent = null;
    selectedStartTimeCreateEvent = null;
    selectedEndTimeCreateEvent = null;
  }

  createEvent({
    required String eventName,
    required String eventAddress,
    required String organizerName,
    required String organizationName,
    required String organizationPhoneNumber,
    required String organizationEmail,
    required String organizationWebsite,
    required String ticketEventLink,
    required String eventPrice,
    required String eventDescription,
  }) async {
    printYellow(eventName);
    emit(CreateEventLoading());
    final response = await homeRepo.createEvent(
      eventImage: eventImage!,
      eventName: eventName,
      eventAddress: eventAddress,
      organizerName: organizerName,
      organizationName: organizationName,
      organizationPhoneNumber: organizationPhoneNumber,
      organizationEmail: organizationEmail,
      organizationWebsite: organizationWebsite,
      ticketEventLink: ticketEventLink,
      eventPrice: eventPrice,
      eventDescription: eventDescription,
      eventLocation: selectedCityCreateEvent ?? "",
      eventCategory: selectedCategoryIdCreateEvent ?? "",
      organizerPlan: selectedorganizerPlan ?? "",
      eventDate: selectedEventDateCreateEvent.toString(),
      eventStartTime: selectedStartTimeCreateEvent.toString(),
      eventEndTime: selectedEndTimeCreateEvent.toString(),
    );
    response.fold(
      (l) {
        emit(CreateEventError(l));
      },
      (r) {
        emit(CreateEventSuccess());
      },
    );
  }

  //! Create Organizer
  createOrganizer({
    required String organizerName,
    required String organizationName,
    required String organizationField,
    required String organizationWebsite,
    required String organizationPhoneNumber,
    required String organizationEmail,
    required String adviceCreateOrganizer,
  }) async {
    emit(CreateOrganizerLoading());
    final response = await homeRepo.createOrganizer(
      organizerName: organizerName,
      organizationName: organizationName,
      organizationField: organizationField,
      organizationWebsite: organizationWebsite,
      organizationPhoneNumber: organizationPhoneNumber,
      organizationEmail: organizationEmail,
      advice: adviceCreateOrganizer,
    );
    response.fold(
      (l) {
        emit(CreateOrganizerError(l));
      },
      (r) {
        emit(CreateOrganizerSuccess());
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
