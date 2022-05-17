import 'package:football_app/models/competition.dart';
import 'package:football_app/models/football_team.dart';

class CompetitionMostWins {
  final Competition competition;
  final FootballTeam teamWithMostWins;

  CompetitionMostWins(this.competition, this.teamWithMostWins);
}