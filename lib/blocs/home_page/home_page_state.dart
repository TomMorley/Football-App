part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {}

class HomePageData extends HomePageState {
  final List<CompetitionMostWins> competitionWins;

  const HomePageData(this.competitionWins);
}

class HomePageError extends HomePageState {
  final String errorMessage;

  const HomePageError(this.errorMessage);
}
