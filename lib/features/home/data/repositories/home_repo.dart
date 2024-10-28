import 'package:dartz/dartz.dart';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/home/data/models/all_categories_model/all_categories_model.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/events_model.dart';
import 'package:eventown/features/home/data/models/wish_list_model/wish_list_model.dart';
import 'package:eventown/features/settings/data/models/calender_model/calender_model.dart';
import 'package:image_picker/image_picker.dart';

class HomeRepo {
  final ApiConsumer api;

  HomeRepo(this.api);
  //! Categories
  Future<Either<String, AllCategoriesModel>> fetchHomeCategories() async {
    try {
      final response = await api.get(
        EndPoints.getCategories,
      );
      final allCategoriesModel = AllCategoriesModel.fromJson(response);
      return Right(allCategoriesModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Top Events
  Future<Either<String, EventsModel>> fetchHomeTopEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getTopEvents,
        queryParameters: queryParameters,
      );
      final topEventsModel = EventsModel.fromJson(response);
      return Right(topEventsModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! On This Week Events
  Future<Either<String, EventsModel>> fetchHomeOnThisWeekEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getWeekEvents,
        queryParameters: queryParameters,
      );
      final thisWeekModel = EventsModel.fromJson(response);
      return Right(thisWeekModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! For You Events
  Future<Either<String, EventsModel>> fetchHomeForYouEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getForYouEvents,
        queryParameters: queryParameters,
      );
      final forYouModel = EventsModel.fromJson(response);
      return Right(forYouModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! In Your Area Events
  Future<Either<String, EventsModel>> fetchHomeInYourAreaEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getInYourAreaEvents,
        queryParameters: queryParameters,
      );
      final inYourAreaModel = EventsModel.fromJson(response);
      return Right(inYourAreaModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! All Events
  Future<Either<String, EventsModel>> fetchAllEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getEvents,
        queryParameters: queryParameters,
      );
      final eventsModel = EventsModel.fromJson(response);
      return Right(eventsModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Add Event to Wishlist
  Future<Either<String, String>> addEventToWishlist(String eventId) async {
    try {
      final response = await api.post(
        EndPoints.addToWishlist,
        data: {'eventId': eventId},
      );
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Remove Event from Wishlist
  Future<Either<String, String>> removeEventFromWishlist(String eventId) async {
    try {
      final response = await api.delete(
        EndPoints.removeFromWhishList(eventId),
      );
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get Wishlist Events
  Future<Either<String, WishListModel>> fetchWishlistEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getWishlist,
        queryParameters: queryParameters,
      );
      final wishlistModel = WishListModel.fromJson(response);
      return Right(wishlistModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get Events By Category
  Future<Either<String, EventsModel>> fetchEventsByCategory({
    required String categoryId,
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getEventsByCategory(categoryId),
        queryParameters: queryParameters,
      );
      final eventsModel = EventsModel.fromJson(response);
      return Right(eventsModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get Event Details
  Future<Either<String, EventModel>> fetchEventDetails(String eventId) async {
    try {
      final response = await api.get(
        EndPoints.getEventById(eventId),
      );
      final eventModel = EventModel.fromJson(response['data']);
      return Right(eventModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Search Events
  Future<Either<String, EventsModel>> searchEvents({
    required String query,
    int? page,
    int? limit,
    String? eventCategory,
    String? startDate,
    String? endDate,
    bool? isSortByPrice,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {'keyword': query};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      if (eventCategory != null) {
        queryParameters.addAll({'eventCategory': eventCategory});
      }
      if (startDate != null) {
        queryParameters.addAll({'eventDate[gte]': startDate});
      }
      if (endDate != null) {
        queryParameters.addAll({'eventDate[lt]': endDate});
      }
      if (isSortByPrice != null && isSortByPrice == true) {
        queryParameters.addAll({'sort': 'eventPrice'});
      }
      final response = await api.get(
        EndPoints.getEvents,
        queryParameters: queryParameters,
      );
      final eventsModel = EventsModel.fromJson(response);
      return Right(eventsModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get Calendar Events
  Future<Either<String, CalenderModel>> fetchCalendarEvents({
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {};
      if (page != null) {
        queryParameters.addAll({'page': page});
      }
      if (limit != null) {
        queryParameters.addAll({'limit': limit});
      }
      final response = await api.get(
        EndPoints.getCalendarEvents,
        queryParameters: queryParameters,
      );
      final calendarModel = CalenderModel.fromJson(response);
      return Right(calendarModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Add Events to Calendar
  Future<Either<String, String>> addEventToCalendar(String eventId) async {
    try {
      final response = await api.post(
        EndPoints.addToCalendar,
        data: {
          'eventId': eventId,
        },
      );
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Remove Event from Calendar
  Future<Either<String, String>> removeEventFromCalendar(String eventId) async {
    try {
      final response = await api.delete(
        EndPoints.removeFromCalandar(eventId),
      );
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Delete My Account
  Future<Either<String, String>> deleteMyAccount() async {
    try {
      await api.delete(
        EndPoints.deleteMyAccount,
      );
      return const Right("Account Deleted Successfully");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //!Create Event
  Future<Either<String, String>> createEvent({
    required XFile eventImage,
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
    required String eventLocation,
    required String eventCategory,
    required String eventDate,
    required String eventStartTime,
    required String eventEndTime,
    required String organizerPlan,
  }) async {
    try {
      await api.post(EndPoints.createEvents,
          data: {
            'eventImage': await uploadImageToAPI(eventImage),
            'eventName': eventName,
            'eventAddress': eventAddress,
            'organizerName': organizerName,
            'organizationName': organizationName,
            'organizationPhoneNumber': organizationPhoneNumber,
            'organizationEmail': organizationEmail,
            'organizationWebsite': organizationWebsite,
            'ticketEventLink': ticketEventLink,
            'eventPrice': eventPrice,
            'eventDescription': eventDescription,
            'eventLocation': eventLocation,
            'eventCategory': eventCategory,
            'eventDate': eventDate,
            'eventStartTime': eventStartTime,
            'eventEndTime': eventEndTime,
            'organizerPlan': organizerPlan
          },
          isFormData: true);
      return const Right("created");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
