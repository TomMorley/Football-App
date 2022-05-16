import 'package:football_app/models/football_match.dart';
import 'package:football_app/models/season.dart';

class Competition {
  final int id;
  final String name;
  final Season currentSeason;
  final String emblemUrl;
  final List<FootballMatch> matches;

  Competition(this.id, this.name, this.currentSeason, this.matches, this.emblemUrl);

  Competition.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        name = json["name"],
        currentSeason = Season.fromJson(json['currentSeason']),
        emblemUrl = json["emblemUrl"],
        matches = json.containsKey("matches") ? List.generate(json["matches"].length, (index) => FootballMatch.fromJson(json["matches"][index])) : [];
}