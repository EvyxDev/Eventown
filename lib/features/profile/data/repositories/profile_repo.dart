import 'package:dartz/dartz.dart';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/databases/api/api_consumer.dart';
import 'package:eventown/core/databases/api/end_points.dart';
import 'package:eventown/core/errors/exceptions.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepo {
  final ApiConsumer api;

  ProfileRepo(this.api);

  Future<Either<String, String>> updateProfile({
    required String name,
    required String phone,
    required String gender,
    required String location,
    XFile? profileImg,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'phone': phone,
        'location': location,
        'gender': gender,
      };
      if (profileImg != null) {
        data['profileImg'] = await uploadImageToAPI(profileImg);
      }
      await api.put(
        EndPoints.changeUserData,
        isFormData: true,
        data: data,
      );
      return const Right("updated");
    } on ServerException catch (e) {
      return Left(e.errorModel.detail);
    } on NoInternetException catch (e) {
      return Left(e.errorModel.detail);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
