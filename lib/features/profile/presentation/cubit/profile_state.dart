class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}

final class ChangePasswordLoading extends ProfileState {}

final class ChangePasswordSuccess extends ProfileState {}

final class ChangePasswordError extends ProfileState {
  final String error;
  ChangePasswordError(this.error);
}
