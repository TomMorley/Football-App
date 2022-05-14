import 'package:football_app/utils/constants.dart';

class Utils {
  static matchStatusFromString(String statusString) {
    switch(statusString) {
      case "SCHEDULED":
        return MatchStatus.SCHEDULED;
      case "LIVE":
        return MatchStatus.LIVE;
      case "IN_PLAY":
        return MatchStatus.IN_PLAY;
      case "PAUSED":
        return MatchStatus.PAUSED;
      case "FINISHED":
        return MatchStatus.FINISHED;
      case "POSTPONED":
        return MatchStatus.POSTPONED;
      case "SUSPENDED":
        return MatchStatus.SUSPENDED;
      case "CANCELED":
        return MatchStatus.CANCELED;
    }
  }
}