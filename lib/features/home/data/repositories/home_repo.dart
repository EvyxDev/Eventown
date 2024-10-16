// import 'package:dartz/dartz.dart';
// import 'package:eventown/features/home/data/models/all_categories_model/all_categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:eventown/features/home/data/models/all_categories_model/all_categories_model.dart';

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
  //! On This Week Events
  //! For You Events
  //! In Your Area Events
  //! All Events
}
