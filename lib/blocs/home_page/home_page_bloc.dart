import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_app/data/data_manager.dart';
import 'package:football_app/models/competition.dart';
import 'package:football_app/models/competition_most_wins.dart';
import 'package:football_app/models/data_response.dart';
import 'package:football_app/models/football_match.dart';
import 'package:football_app/models/football_team.dart';
import 'package:football_app/utils/constants.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final DataManager repository = DataManager();

  HomePageBloc() : super(HomePageLoading()) {
    on<HomePageEvent>((event, emit) async {
      if(event is FetchHomePageData) {
        await fetchHomePageData(emit);
      }
    });
  }

  Future<void> fetchHomePageData(Emitter<HomePageState> emit) async {
    emit(HomePageLoading());

    List<CompetitionMostWins> competitionWinsList = [];
    for(int competitionId in Constants.COMPETITION_IDS) {
      DataResponse<Competition> competitionResponse = await repository.getCompetition(competitionId);
      if(competitionResponse.data != null) {
        CompetitionMostWins competitionMostWins = await getCompetitionMostWins(emit, competitionResponse.data!);
        competitionWinsList.add(competitionMostWins);
      }
    }

    emit(HomePageData(competitionWinsList));
  }

  Future<CompetitionMostWins> getCompetitionMostWins(Emitter<HomePageState> emit, Competition competition) async {
    DataResponse<List<FootballMatch>> matchesResponse = await getLastThirtyDaysMatches(competition);
    if(matchesResponse.error != null) {
      await handleError(emit, matchesResponse.error!);
    }
    List<String> winnerIds = [];
    if(matchesResponse.data != null) {
      final map = <String, int>{};
      for(final FootballMatch match in matchesResponse.data!.where((element) => element.winningTeam != null)) {

        map[match.winningTeam!.name] = map.containsKey(match.winningTeam!.name) ? map[match.winningTeam!.name]! + 1 : 1;
      }

      winnerIds = map.keys.toList(growable: false);
      winnerIds.sort((k1, k2) => map[k2]!.compareTo(map[k1]!));
    }

    return CompetitionMostWins(competition, winnerIds.first);
  }

  Future<DataResponse<List<FootballMatch>>> getLastThirtyDaysMatches(Competition competition) async {
    DateTime dateFrom = DateTime.now().subtract(const Duration(days: 30));
    DateTime competitionEndDate = competition.currentSeason.endDate!;
    if(DateTime.now().isAfter(competitionEndDate)) {
      dateFrom = competition.currentSeason.endDate!.subtract(const Duration(days: 30));
    }

    return repository.getCompetitionMatches(competition.id, dateFrom: dateFrom, dateTo: DateTime.now());
  }

  Future<void> handleError(Emitter<HomePageState> emit, String errorMessage) async {
    emit(HomePageError(errorMessage));
  }


}
