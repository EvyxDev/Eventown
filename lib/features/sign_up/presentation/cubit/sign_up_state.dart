class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class GetAllCategoriesLoading extends SignUpState {}

final class GetAllCategoriesSuccess extends SignUpState {}

final class GetAllCategoriesFailed extends SignUpState {
  final String message;
  GetAllCategoriesFailed(this.message);
}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFailed extends SignUpState {
  final String message;
  SignUpFailed(this.message);
}
