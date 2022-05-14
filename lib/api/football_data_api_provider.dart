import 'package:dio/dio.dart';
import 'package:football_app/models/data_response.dart';
import 'package:football_app/models/football_match.dart';
import 'package:football_app/utils/constants.dart';
import 'package:intl/intl.dart';

class FootballDataApiProvider {

  final Dio _dio = Dio();
  final String _apiBaseUrl = "https://api.football-data.org/v2";

  final String _matchesEndpoint = "/matches";
  final String _competitionsEndpoint = "/competitions";

  static final FootballDataApiProvider _instance = FootballDataApiProvider._internal();


  FootballDataApiProvider._internal() {
    setupInterceptors();
  }

  factory FootballDataApiProvider() {
    return _instance;
  }

  void setupInterceptors() {

  }

  Future<DataResponse> getCompetitionMatches(int competitionId, {DateTime? dateTo, DateTime? dateFrom}) async {
    try {
      _dio.options.headers = {
        "Accept" : "application/json",
        "X-Auth-Token" : Constants.API_TOKEN
      };

      Map<String, dynamic> queryParams = {};

      if(dateTo != null && dateFrom != null) {
        //2021-08-08
        queryParams['dateTo'] = DateFormat('yyyy-MM-dd').format(dateTo);
        queryParams['dateFrom'] = DateFormat('yyyy-MM-dd').format(dateFrom);
      }

      Response response = await _dio.get("$_apiBaseUrl$_competitionsEndpoint/$competitionId/$_matchesEndpoint", queryParameters: queryParams);

      List<FootballMatch> matches = List.generate(response.data['matches'].length, (index) {
        return FootballMatch.fromJson(response.data['matches'][index]);
      });

      return DataResponse.fromData(matches);
    } catch(e) {
      return DataResponse.withError(e.toString());
    }
  }
}