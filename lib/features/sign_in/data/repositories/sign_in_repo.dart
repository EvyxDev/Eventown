import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/settings/data/models/user/user.dart';
import 'package:eventown/features/sign_in/data/models/sign_in.dart';

class SignInRepo {
  final ApiConsumer api;

  SignInRepo(this.api);

  Future<Either<String, SignInModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await api.post(
        EndPoints.signIn,
        data: {
          "email": email,
          "password": password,
        },
      );
      return Right(SignInModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPoints.getUserData,
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }
}
