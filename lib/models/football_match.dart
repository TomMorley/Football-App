class FootballMatch {
  final int id;
  final String status;
  final String winner;
  final int winnerId;

  FootballMatch(this.id, this.status, this.winner, this.winnerId);


  FootballMatch.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        status = json["status"],
        winner = json["score"]["winner"],
        winnerId = getWinnerId(json);

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