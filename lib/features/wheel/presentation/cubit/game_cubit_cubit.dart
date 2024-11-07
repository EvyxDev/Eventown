import 'dart:async';
import 'package:eventown/core/common/common.dart';
import 'package:eventown/core/cubit/global_cubit.dart';
import 'package:eventown/core/databases/cache/cache_helper.dart';
import 'package:eventown/core/services/service_locator.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/wheel/data/models/game_comments/comment.dart';
import 'package:eventown/features/wheel/data/models/game_comments/user.dart';
import 'package:eventown/features/wheel/data/models/requests_history_model/requests_history_model.dart';
import 'package:eventown/features/wheel/data/repositories/wheel_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'game_cubit_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.wheelRepo) : super(GameInitial());
  final WheelRepo wheelRepo;
  BehaviorSubject<int> selected = BehaviorSubject<int>();
  final List<int> items = [10, 25, 50, 75, 100, 150, 200];
  int totalPoints = 1000;
  DateTime lastSpinTime = DateTime.fromMillisecondsSinceEpoch(
      sl<CacheHelper>().getData(key: "last_spin_time") ?? 0);
  Timer timer = Timer.periodic(const Duration(seconds: 1), (x) {});

  Future<void> saveLastSpinTime() async {
    await sl<CacheHelper>().saveData(
        key: 'last_spin_time', value: lastSpinTime.millisecondsSinceEpoch);
  }

  Duration getRemainingTime() {
    final timeSinceLastSpin = DateTime.now().difference(lastSpinTime);
    final remainingTime = const Duration(days: 1) - timeSinceLastSpin;
    emit(GameInitial());
    return remainingTime.isNegative ? Duration.zero : remainingTime;
  }

  //! Get Game Data
  getGameData() async {
    emit(GetMyPointsLoading());
    await getMyPoints();
    await getAllComments();
    emit(GetMyPointsSuccess());
  }

  //! Get My Points
  int myPoint = 0;
  getMyPoints() async {
    // emit(GetMyPointsLoading());
    final response = await wheelRepo.getMyPoints();
    response.fold(
      (l) {
        // emit(GetMyPointsError(l));
      },
      (r) {
        myPoint = r.myPoints?.points ?? 0;
        // emit(GetMyPointsSuccess());
      },
    );
  }

  //! Add Points to My Account
  addPointsToMyAccount(int points) async {
    emit(AddPointsToMyAccountLoading());
    final response = await wheelRepo.addPointsToMyAccount(points: points);
    response.fold(
      (l) {
        getMyPoints();
        emit(AddPointsToMyAccountError(l));
      },
      (r) {
        getMyPoints();
        emit(AddPointsToMyAccountSuccess());
      },
    );
  }

  //! Get My Requests History
  RequestsHistoryModel? myRequestsHistory;
  getMyRequestsHistory() async {
    emit(GetMyRequestsHistoryLoading());
    final response = await wheelRepo.getMyRequestsHistory();
    response.fold(
      (l) {
        emit(GetMyRequestsHistoryError(l));
      },
      (r) {
        myRequestsHistory = r;
        emit(GetMyRequestsHistorySuccess());
      },
    );
  }

  //! Get All Comments
  List<Comment> allComments = [];
  getAllComments() async {
    // emit(GetAllCommentsLoading());
    final response = await wheelRepo.getAllComments();
    response.fold(
      (l) {
        // emit(GetAllCommentsError(l));
      },
      (r) {
        allComments = r.comments ?? [];
        // emit(GetAllCommentsSuccess());
      },
    );
  }

  //! Add Comment
  final TextEditingController commentController = TextEditingController();
  XFile? imageFile;
  addComment(context) async {
    emit(AddCommentLoading());
    allComments.insert(
      0,
      Comment(
        id: generateRandomString(15),
        text: commentController.text.trim(),
        user: User(
          name: GlobalCubit.get(context).user?.data?.name,
          profileImg: GlobalCubit.get(context).user?.data?.profileImg,
        ),
      ),
    );
    final response = await wheelRepo.addComment(
      comment: commentController.text.trim(),
      image: imageFile,
    );
    response.fold(
      (l) {
        allComments.removeAt(0);
        emit(AddCommentError(l));
      },
      (r) {
        emit(AddCommentSuccess());
      },
    );
  }

  //! Request free ticket
  List<EventModel> selectedEvents = [];
  updateSelectedEvents(BuildContext context, EventModel event) {
    if (selectedEvents.contains(event)) {
      selectedEvents.remove(event);
    } else {
      if (selectedEvents.length != 3) {
        selectedEvents.add(event);
      } else {
        showTwist(context: context, messege: "You can select only 3 events");
      }
    }
    emit(GameInitial());
  }

  bool isEventSelected(EventModel event) {
    return selectedEvents.contains(event);
  }

  requestFreeTicket({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    emit(RequestFreeTicketLoading());
    final response = await wheelRepo.requestFreeTicket(
      name: name,
      email: email,
      phone: phone,
      address: address,
      event1: selectedEvents[0].id ?? "",
      event2: selectedEvents[1].id ?? "",
      event3: selectedEvents[2].id ?? "",
    );
    response.fold(
      (l) {
        emit(RequestFreeTicketError(l));
      },
      (r) {
        emit(RequestFreeTicketSuccess());
      },
    );
  }
}
