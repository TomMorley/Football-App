import 'package:football_app/utils/constants.dart';
import 'package:football_app/utils/utils.dart';

class FootballMatch {
  final int id;
  final MatchStatus status;
  final String? winner;
  final int? winnerId;

  FootballMatch(this.id, this.status, this.winner, this.winnerId);


  FootballMatch.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        status = Utils.matchStatusFromString(json["status"]),
        winner = Utils.matchStatusFromString(json["status"]) == MatchStatus.FINISHED ? json["score"]["winner"] : null,
        winnerId = Utils.matchStatusFromString(json["status"]) == MatchStatus.FINISHED ? getWinnerId(json) : null;

  static int getWinnerId(Map<String, dynamic> json) {
    if(json["score"]["winner"] == "HOME_TEAM") {
      return json["homeTeam"]["id"];
    } else if (json["score"]["winner"] == "AWAY_TEAM") {
      return json["awayTeam"]["id"];
    } else {
      return 0;
    }
  }
}