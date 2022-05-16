import 'package:football_app/models/football_team.dart';
import 'package:football_app/utils/constants.dart';
import 'package:football_app/utils/utils.dart';

class FootballMatch {
  final int id;
  final MatchStatus status;
  final String? winner;
  final FootballTeam? winningTeam;

  FootballMatch(this.id, this.status, this.winner, this.winningTeam);


  FootballMatch.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        status = Utils.matchStatusFromString(json["status"]),
        winner = Utils.matchStatusFromString(json["status"]) == MatchStatus.FINISHED ? json["score"]["winner"] : null,
        winningTeam = Utils.matchStatusFromString(json["status"]) == MatchStatus.FINISHED ? getWinningTeam(json) : null;

  static FootballTeam? getWinningTeam(Map<String, dynamic> json) {
    if(json["score"]["winner"] == "HOME_TEAM") {
      return FootballTeam.fromJson(json["homeTeam"]);
    } else if (json["score"]["winner"] == "AWAY_TEAM") {
      return FootballTeam.fromJson(json["awayTeam"]);
    } else {
      return null;
    }
  }
}