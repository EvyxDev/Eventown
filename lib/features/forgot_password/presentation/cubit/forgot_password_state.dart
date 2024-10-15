class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {}

final class ForgotPasswordFailed extends ForgotPasswordState {
  final String message;
  ForgotPasswordFailed(this.message);
}

final class OtpForgotPasswordLoading extends ForgotPasswordState {}

final class OtpForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  OtpForgotPasswordSuccess(this.email);
}

final class OtpForgotPasswordFailed extends ForgotPasswordState {
  final String message;
  OtpForgotPasswordFailed(this.message);
}

final class ResetPasswordLoading extends ForgotPasswordState {}

final class ResetPasswordSuccess extends ForgotPasswordState {}

final class ResetPasswordFailed extends ForgotPasswordState {
  final String message;
  ResetPasswordFailed(this.message);
}
