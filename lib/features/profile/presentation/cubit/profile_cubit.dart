import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/features/profile/data/repositories/profile_repo.dart';
import 'package:eventown/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  initControllers(
    String fullName,
    String phone,
    String? location,
    String? gender,
  ) {
    fullNameController.text = fullName;
    phoneController.text = phone;
    selectedGender = gender;
    selectedLocation = location;
    emit(ProfileInitial());
  }

  XFile? selectedProfileImage;
  updateSelectedProfileImage(XFile? image) {
    selectedProfileImage = image;
    emit(ProfileInitial());
  }

  String? selectedLocation;
  updateSelectedLocation(String location) {
    selectedLocation = location;
    emit(ProfileInitial());
  }

  String? selectedGender;
  updateSelectedGender(String gender) {
    selectedGender = gender;
    emit(ProfileInitial());
  }

  void updateProfile() async {
    emit(ProfileLoading());
    final response = await repo.updateProfile(
      name: fullNameController.text,
      phone: "+20${phoneController.text}",
      gender: selectedGender ?? "",
      location: selectedLocation ?? "",
      profileImg: selectedProfileImage,
    );
    response.fold(
      (error) {
        emit(ProfileError(error));
      },
      (data) {
        emit(ProfileSuccess());
      },
    );
  }

  bool isUserDataChanged(context) {
    if (selectedGender == GlobalCubit.get(context).user?.data?.gender &&
        selectedLocation == GlobalCubit.get(context).user?.data?.location &&
        fullNameController.text == GlobalCubit.get(context).user?.data?.name &&
        "+20${phoneController.text}" ==
            GlobalCubit.get(context).user?.data?.phone &&
        selectedProfileImage == null) {
      return false;
    } else {
      return true;
    }
  }

  updateUI() {
    emit(ProfileInitial());
  }

  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  bool isPasswordObsure = true;
  void changePasswordObsure() {
    isPasswordObsure = !isPasswordObsure;
    emit(ProfileInitial());
  }

  bool isConfPasswordObsure = true;
  void changeConfPasswordObsure() {
    isConfPasswordObsure = !isConfPasswordObsure;
    emit(ProfileInitial());
  }

  bool isOldPassordObsure = true;
  void changeOldPasswordObsure() {
    isOldPassordObsure = !isOldPassordObsure;
    emit(ProfileInitial());
  }

  void changePassword() async {
    emit(ProfileLoading());
    final response = await repo.changePassword(
      oldPassword: oldPasswordController.text,
      password: passwordController.text,
      confPassword: confPasswordController.text,
    );
    response.fold(
      (error) {
        emit(ProfileError(error));
      },
      (data) {
        emit(ProfileSuccess());
      },
    );
  }
}
