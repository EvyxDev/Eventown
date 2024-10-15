import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/sign_up/data/models/all_categories_model/all_categories_model.dart';

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
}
