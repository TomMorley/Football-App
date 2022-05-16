import 'package:football_app/utils/constants.dart';
import 'package:football_app/utils/utils.dart';

class Season {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;

  Season(this.id, this.startDate, this.endDate, );


  Season.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']);
}