import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/models/competition_most_wins.dart';

class CompetitionWinsListItem extends StatelessWidget {
  final CompetitionMostWins competitionMostWins;

  const CompetitionWinsListItem({Key? key, required this.competitionMostWins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  competitionMostWins.competition.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 6.0,),
                Text(
                  competitionMostWins.teamWithMostWins,
                  style: const TextStyle(
                      fontSize: 14
                  ),
                )
              ],
            ),
            Image.network(
              competitionMostWins.competition.emblemUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            )
          ],
        ),
      ),
    );
  }
}