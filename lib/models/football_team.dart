import 'package:equatable/equatable.dart';

class FootballTeam extends Equatable {
  final int id;
  final String name;

  const FootballTeam(this.id, this.name);


  FootballTeam.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        name = json["name"];

  @override
  List<Object?> get props => [id];
}