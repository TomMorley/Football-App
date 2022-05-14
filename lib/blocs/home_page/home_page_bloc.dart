import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/data/data_manager.dart';
import 'package:football_app/models/data_response.dart';
import 'package:football_app/models/football_match.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final DataManager repository = DataManager();

  HomePageBloc() : super(HomePageLoading()) {
    on<HomePageEvent>((event, emit) async {
      if(event is FetchHomePageData) {
        emit(HomePageLoading());
        DataResponse response = await repository.getCompetitionMatches(2021);
        emit(HomePageData(response.data));
      }
    });
  }
}
