import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/wheel/data/models/game_comments/game_comments.dart';
import 'package:eventown/features/wheel/data/models/points_model/points_model.dart';
import 'package:eventown/features/wheel/data/models/requests_history_model.dart';
import 'package:image_picker/image_picker.dart';

class WheelRepo {
  final ApiConsumer api;

  WheelRepo(this.api);

  //! Get My Points
  Future<Either<String, PointsModel>> getMyPoints() async {
    try {
      final response = await api.get(
        EndPoints.getMyPoints,
      );
      return Right(PointsModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Add points to my account
  Future<Either<String, String>> addPointsToMyAccount({
    required int points,
  }) async {
    try {
      await api.post(
        EndPoints.addPoints,
        data: {
          'points': points,
        },
      );
      return const Right("Points added successfully");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get My Requests history
  Future<Either<String, RequestsHistoryModel>> getMyRequestsHistory() async {
    try {
      final response = await api.get(
        EndPoints.myHistory,
      );
      return Right(RequestsHistoryModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Get all comments
  Future<Either<String, GameComments>> getAllComments() async {
    try {
      final response = await api.get(
        EndPoints.getComments,
      );
      return Right(GameComments.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Add comment
  Future<Either<String, String>> addComment({
    required String comment,
    required XFile? image,
  }) async {
    try {
      await api.post(
        EndPoints.addComment,
        data: {
          'text': comment,
          // 'img': await uploadImageToAPI(image),
        },
        isFormData: true,
      );
      return const Right("Comment added successfully");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  //! Request free ticket
  Future<Either<String, String>> requestFreeTicket({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String event1,
    required String event2,
    required String event3,
  }) async {
    try {
      await api.post(
        EndPoints.requestFreeTicket,
        data: {
          {
            "name": name,
            "email": email,
            "phone": phone,
            "address": address,
            "event1": event1,
            "event2": event2,
            "event3": event3,
          }
        },
      );
      return const Right("Ticket requested successfully");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
