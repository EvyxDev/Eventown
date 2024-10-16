import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/home/data/models/all_categories_model/all_categories_model.dart';
import 'package:eventown/features/sign_up/data/models/sign_up_model/sign_up_model.dart';

class SignUpRepo {
  final ApiConsumer api;
  SignUpRepo(this.api);

  Future<Either<String, AllCategoriesModel>> getAllCategories() async {
    try {
      final response = await api.get(
        EndPoints.getCategories,
      );
      return Right(AllCategoriesModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String location,
    required String gender,
    required String phone,
    required List<String> interests,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signUp,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "location": location,
          "gender": gender,
          "phone": phone,
          "interests": interests,
        },
      );
      return Right(SignUpModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, String>> verifyOtp({required String otp}) async {
    try {
      await api.post(
        EndPoints.verfiyEmailCode,
        data: {
          "emailVerifyCode": otp,
        },
      );
      return const Right("Success");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    }
  }

  Future<Either<String, String>> resendCode({required String email}) async {
    try {
      await api.post(
        EndPoints.resendCode,
        data: {
          "email": email,
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
