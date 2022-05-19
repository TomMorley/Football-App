import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
  final DataManager repository;

  HomePageBloc({required this.repository}) : super(HomePageLoading()) {
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
      //Get Competition Details - Used to see if Competition already Finished
      DataResponse<Competition> competitionResponse = await repository.getCompetition(competitionId);
      if(competitionResponse.data != null) {
        DataResponse<CompetitionMostWins> competitionMostWinsResponse = await getCompetitionMostWins(emit, competitionResponse.data!);
        if(competitionMostWinsResponse.data != null) {
          competitionWinsList.add(competitionMostWinsResponse.data!);
        } else {
          handleError(emit, competitionMostWinsResponse);
        }
      } else {
        handleError(emit, competitionResponse);
      }
    }

    if(competitionWinsList.isEmpty) {
      emit(HomePageBlankState());
    } else {
      emit(HomePageData(competitionWinsList));
    }
  }

  Future<DataResponse<CompetitionMostWins>> getCompetitionMostWins(Emitter<HomePageState> emit, Competition competition) async {
    DataResponse<List<FootballMatch>> matchesResponse = await getLastThirtyDaysMatches(competition);

    if(matchesResponse.data != null) {
      DataResponse<FootballTeam> teamWithMostWinsResponse = await getTeamWithMostWins(matchesResponse.data!);

      if(teamWithMostWinsResponse.data != null) {
        return DataResponse.fromData(CompetitionMostWins(competition, teamWithMostWinsResponse.data!));
      } else {
        return DataResponse.withError(teamWithMostWinsResponse.error);
      }

    } else {
      return DataResponse.withError(matchesResponse.error);
    }
  }

  Future<DataResponse<FootballTeam>> getTeamWithMostWins(List<FootballMatch> matches) async {
    List<int> winnerIds = [];
    //Create Map of <teamId, numberOfMatchesWon> from last 30 Days Matches Data
    final teamIdMatchesWon = <int, int>{};
    for(final FootballMatch match in matches.where((match) => match.winningTeam != null)) {
      teamIdMatchesWon[match.winningTeam!.id] = teamIdMatchesWon.containsKey(match.winningTeam!.id) ? teamIdMatchesWon[match.winningTeam!.id]! + 1 : 1;
    }

    //Sort map by number of Matches Won
    winnerIds = teamIdMatchesWon.keys.toList(growable: false);
    winnerIds.sort((k1, k2) => teamIdMatchesWon[k2]!.compareTo(teamIdMatchesWon[k1]!));


    //Fetch Details of Team with most wins
    DataResponse<FootballTeam> footballTeamResponse = await repository.getTeam(winnerIds.first);
    if(footballTeamResponse.data != null) {
      return DataResponse.fromData(footballTeamResponse.data);
    } else {
      return DataResponse.withError(footballTeamResponse.error);
    }
  }

  Future<DataResponse<List<FootballMatch>>> getLastThirtyDaysMatches(Competition competition) async {

    //Default Date - 30 Days from now. If Competition Ended, use 30 Days from endDate
    DateTime dateFrom = DateTime.now().subtract(const Duration(days: 30));
    DateTime dateTo = DateTime.now();

    DateTime competitionEndDate = competition.currentSeason.endDate!;
    if(DateTime.now().isAfter(competitionEndDate)) {
      dateFrom = competition.currentSeason.endDate!.subtract(const Duration(days: 30));
      dateTo = competition.currentSeason.endDate!;
    }

    return repository.getCompetitionMatches(competition.id, dateFrom: dateFrom, dateTo: dateTo);
  }

  Future<void> handleError(Emitter<HomePageState> emit, DataResponse errorResponse) async {
    if(errorResponse.error != null) {
      emit(HomePageError(errorResponse.error!));
    } else {
      emit(HomePageError("Something went wrong, please try again."));
    }
  }


}
