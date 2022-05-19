
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_app/api/football_data_api_provider.dart';
import 'package:football_app/blocs/home_page/home_page_bloc.dart';
import 'package:football_app/data/data_manager.dart';

import 'package:football_app/main.dart';
import 'package:football_app/models/competition.dart';
import 'package:football_app/models/competition_most_wins.dart';
import 'package:football_app/models/data_response.dart';
import 'package:football_app/models/football_match.dart';
import 'package:football_app/models/football_team.dart';
import 'package:football_app/models/season.dart';
import 'package:football_app/utils/constants.dart';
import 'package:mockito/mockito.dart';


final List<CompetitionMostWins> _mockCompetitionWins = [
  CompetitionMostWins(
      _mockCompetition,
      _mockTeam
  )
];
final Season _mockSeason = Season(12, DateTime.now().subtract(Duration(days: 365)), DateTime.now());
final Competition _mockCompetition = Competition(12, 'Premier League', _mockSeason, [], '');
final FootballTeam _mockTeam = FootballTeam(12, 'Liverpool');
final FootballMatch _mockFootballMatch = FootballMatch(12, MatchStatus.FINISHED, 'HOME_TEAM', _mockTeam);

class MockFootballDataRepository extends Mock implements DataManager {
  @override
  Future<DataResponse<FootballTeam>> getTeam(int teamId) async {
    return DataResponse.fromData(_mockTeam);
  }

  @override
  Future<DataResponse<List<FootballMatch>>> getCompetitionMatches(int competitionId, {DateTime? dateTo, DateTime? dateFrom}) async {
    return DataResponse.fromData([
      _mockFootballMatch
    ]);
  }

  @override
  Future<DataResponse<Competition>> getCompetition(int competitionId) async {
    return  DataResponse.fromData(_mockCompetition);
  }
}

void main() {
  final MockFootballDataRepository mockFootballDataRepository = MockFootballDataRepository();


  blocTest('Emits [HomePageLoading, HomePageData] when Successful', build:() {
      return HomePageBloc(repository: mockFootballDataRepository);
    },
    act: (HomePageBloc bloc) {
      bloc.add(FetchHomePageData());
    },
    expect: () => <HomePageState>[
      HomePageLoading(),
      HomePageData(_mockCompetitionWins)
    ]
  );
}
