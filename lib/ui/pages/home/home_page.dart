import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/blocs/home_page/home_page_bloc.dart';
import 'package:football_app/models/football_match.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {

    // List<FootballMatch> matches = List.generate(json["matches"].length, (index) {
    //   return FootballMatch.fromJson(json["matches"][index]);
    // });
    //
    // Map<int, List<FootballMatch>> matchesWon = Map();
    // matches.forEach((match) {
    //   if(matchesWon.containsKey(match.winnerId)) {
    //     matchesWon[match.winnerId]!.add(match);
    //   } else {
    //     matchesWon[match.winnerId] = [match];
    //   }
    // });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Football'),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<HomePageBloc>(context),
        builder: (BuildContext context, state) {
          if(state is HomePageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomePageData) {
            return Center(
              child: Text(state.matches.length.toString()),
            );
          } else {
            return const Center(
              child: Text('Test'),
            );
          }
        },

      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}