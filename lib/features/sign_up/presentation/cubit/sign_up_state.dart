class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class GetAllCategoriesLoading extends SignUpState {}

final class GetAllCategoriesSuccess extends SignUpState {}

final class GetAllCategoriesFailed extends SignUpState {
  final String message;
  GetAllCategoriesFailed(this.message);
}
