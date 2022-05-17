import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/blocs/home_page/home_page_bloc.dart';
import 'package:football_app/models/football_match.dart';
import 'package:football_app/ui/common/loading_indicator.dart';
import 'package:football_app/ui/pages/home/widgets/competition_wins_list_item.dart';

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
        body: BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {
            if(state is HomePageError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    state.errorMessage,
                    style: const TextStyle(
                      color: Colors.white
                    ),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: BlocBuilder(
            bloc: BlocProvider.of<HomePageBloc>(context),
            builder: (BuildContext context, HomePageState state) {
              return RefreshIndicator(
                  child: getPageWidgets(state),
                  onRefresh: _onRefresh
              );
            },

          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPageWidgets(HomePageState state) {
    if (state is HomePageLoading) {
      return const Center(
        child: LoadingIndicator(),
      );
    } else if (state is HomePageData) {
      return ListView.builder(
          itemCount: state.competitionWins.length,
          itemBuilder: (context, index) {
            return CompetitionWinsListItem(
                competitionMostWins: state.competitionWins[index]);
          });
    } else {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Center(
            child: Text("Pull to Refresh the Data"),
          ),
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<HomePageBloc>(context).add(FetchHomePageData());
  }


}