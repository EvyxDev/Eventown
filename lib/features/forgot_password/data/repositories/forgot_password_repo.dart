import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';

class ForgotPasswordRepo {
  final ApiConsumer api;

  ForgotPasswordRepo(this.api);

  Future<Either<String, String>> sendPasswordResetEmail(String email) async {
    try {
      await api.post(
        EndPoints.forgetPassword,
        data: {
          'email': email,
        },
      );
      return const Right("Success");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, String>> verifyResetCode(String code) async {
    try {
      await api.post(
        EndPoints.verfiyResetPassword,
        data: {
          'resetCode': code,
        },
      );
      return const Right("Success");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, String>> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      await api.put(
        EndPoints.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
        },
      );
      return const Right("Success");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }
}
