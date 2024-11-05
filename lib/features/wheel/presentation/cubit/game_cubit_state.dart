class GameState {}

final class GameInitial extends GameState {}

final class GetMyPointsLoading extends GameState {}

final class GetMyPointsError extends GameState {
  final String message;
  GetMyPointsError(this.message);
}

final class GetMyPointsSuccess extends GameState {}

final class AddPointsToMyAccountLoading extends GameState {}

final class AddPointsToMyAccountError extends GameState {
  final String message;
  AddPointsToMyAccountError(this.message);
}

final class AddPointsToMyAccountSuccess extends GameState {}

final class GetMyRequestsHistoryLoading extends GameState {}

final class GetMyRequestsHistoryError extends GameState {
  final String message;
  GetMyRequestsHistoryError(this.message);
}

final class GetMyRequestsHistorySuccess extends GameState {}

final class GetAllCommentsLoading extends GameState {}

final class GetAllCommentsError extends GameState {
  final String message;
  GetAllCommentsError(this.message);
}

final class GetAllCommentsSuccess extends GameState {}

final class AddCommentLoading extends GameState {}

final class AddCommentError extends GameState {
  final String message;
  AddCommentError(this.message);
}

final class AddCommentSuccess extends GameState {}

final class RequestFreeTicketLoading extends GameState {}

final class RequestFreeTicketError extends GameState {
  final String message;
  RequestFreeTicketError(this.message);
}

final class RequestFreeTicketSuccess extends GameState {}
