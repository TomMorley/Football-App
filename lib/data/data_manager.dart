import 'package:football_app/api/football_data_api_provider.dart';
import 'package:football_app/models/competition.dart';
import 'package:football_app/models/data_response.dart';
import 'package:football_app/models/football_match.dart';
import 'package:football_app/models/football_team.dart';

class DataManager {
  final FootballDataApiProvider apiProvider = FootballDataApiProvider();

  Future<DataResponse<List<FootballMatch>>> getCompetitionMatches(int competitionId, {DateTime? dateTo, DateTime? dateFrom}) async {
    return apiProvider.getCompetitionMatches(competitionId, dateTo: dateTo, dateFrom: dateFrom);
  }

  Future<DataResponse<Competition>> getCompetition(int competitionId) async {
    return apiProvider.getCompetition(competitionId);
  }

  Future<DataResponse<FootballTeam>> getTeam(int teamId) async {
    return apiProvider.getTeam(teamId);
  }
}