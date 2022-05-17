class Constants {
  static String API_TOKEN = "d562f1e69f514986ac0d0ba61218fc32";
  static int ENGLAND_TIER_1_ID = 2021;
  static int FRENCH_TIER_1_ID = 2015;
  static int GERMAN_TIER_1_ID = 2002;
  static int ITALY_TIER_1_ID = 2019;
  static int SPAIN_TIER_1_ID = 2014;

  static List<int> COMPETITION_IDS = [
    ENGLAND_TIER_1_ID,
    FRENCH_TIER_1_ID,
    // GERMAN_TIER_1_ID,
    // ITALY_TIER_1_ID,
    // SPAIN_TIER_1_ID,
  ];
}

enum MatchStatus {
  SCHEDULED,
  LIVE,
  IN_PLAY,
  PAUSED,
  FINISHED,
  POSTPONED,
  SUSPENDED,
  CANCELED
}