import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/home/data/models/all_categories_model/all_categories_model.dart';
import 'package:eventown/features/home/data/models/events_model/events_model.dart';
import 'package:eventown/features/home/data/models/wish_list_model/wish_list_model.dart';

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
}
