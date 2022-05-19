import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/blocs/home_page/home_page_bloc.dart';
import 'package:football_app/data/data_manager.dart';
import 'package:football_app/ui/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Football',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: BlocProvider(
        create: (BuildContext context) => HomePageBloc(repository: DataManager())..add(FetchHomePageData()),
        child: const HomePage()),
    );
  }
}




