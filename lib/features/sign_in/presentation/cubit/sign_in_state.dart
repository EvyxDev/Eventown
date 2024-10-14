class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInFailed extends SignInState {
  final String message;
  SignInFailed(this.message);
}
