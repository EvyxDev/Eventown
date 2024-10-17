import 'package:eventown/features/home/data/models/all_categories_model/datum.dart';
import 'package:eventown/features/home/data/models/events_model/datum.dart';
import 'package:eventown/features/home/data/repositories/home_repo.dart';
import 'package:eventown/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;

  void getHomeData() async {
    emit(HomeLoading());
    await getHomeCategories();
    await getTopEvents();
    await getOnThisWeekEvents();
    await getForYouEvents();
    await getInYourAreaEvents();
    emit(HomeLoaded());
  }

  //! Home Categories
  List<Category> homeCategories = [];
  getHomeCategories() async {
    final response = await homeRepo.fetchHomeCategories();
    response.fold(
      (l) {},
      (r) {
        homeCategories = r.data ?? [];
      },
    );
  }

  //! Top Events
  List<EventModel> topEvents = [];
  getTopEvents() async {
    final response = await homeRepo.fetchHomeTopEvents();
    response.fold(
      (l) {},
      (r) {
        topEvents = r.data ?? [];
      },
    );
  }

  //! On This Week Events
  List<EventModel> onThisWeekEvents = [];
  getOnThisWeekEvents() async {
    final response = await homeRepo.fetchHomeOnThisWeekEvents();
    response.fold(
      (l) {},
      (r) {
        onThisWeekEvents = r.data ?? [];
      },
    );
  }

  //! For You Events
  List<EventModel> forYouEvents = [];
  getForYouEvents() async {
    final response = await homeRepo.fetchHomeForYouEvents();
    response.fold(
      (l) {},
      (r) {
        forYouEvents = r.data ?? [];
      },
    );
  }

  //! In Your Area Events
  List<EventModel> inYourAreaEvents = [];
  getInYourAreaEvents() async {
    final response = await homeRepo.fetchHomeInYourAreaEvents();
    response.fold(
      (l) {},
      (r) {
        inYourAreaEvents = r.data ?? [];
      },
    );
  }

  //! Get All Events
  List<EventModel> allEvents = [];
  getAllEvents() async {
    final response = await homeRepo.fetchAllEvents();
    response.fold(
      (l) {},
      (r) {
        allEvents = r.data ?? [];
      },
    );
  }
}
