import 'package:football_app/models/football_match.dart';

class Competition {
  final int id;
  final List<FootballMatch> matches;

  Competition(this.id, this.matches);
}