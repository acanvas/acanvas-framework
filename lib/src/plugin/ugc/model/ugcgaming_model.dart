part of rockdot_framework.ugc;


class UGCGamingModel {

  List _games;
  List _highscore;
  List _highscoreFriends;
  int _rank;
  int _gamescore;
  bool _allowedToPlay;

  List get highscoreAll {
    return _highscore;
  }

  void set highscoreAll(List highscore) {
    _highscore = highscore;
  }

  int get rank {
    return _rank;
  }

  void set rank(int rank) {
    _rank = rank;
  }

  void set allowedToPlay(bool allowedToPlay) {
    _allowedToPlay = allowedToPlay;
  }

  int get gamescore {
    return _gamescore;
  }

  void set gamescore(int gamescore) {
    _gamescore = gamescore;
  }

  List get games {
    return _games;
  }

  void set games(List games) {
    _games = games;
  }

  List get highscoreFriends {
    return _highscoreFriends;
  }

  void set highscoreFriends(List highscoreFriends) {
    _highscoreFriends = highscoreFriends;
  }

  bool get allowedToPlay {
    return _allowedToPlay;
  }

}

