import 'package:football_app/api/football_data_api_provider.dart';
import 'package:football_app/models/data_response.dart';

class DataManager {
  final FootballDataApiProvider apiProvider = FootballDataApiProvider();

  Future<DataResponse> getCompetitionMatches(int competitionId) async {
    return apiProvider.getCompetitionMatches(competitionId);
  }
}