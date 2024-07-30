// state.dart
abstract class WordState {}

class WordInitial extends WordState {}

class WordLoading extends WordState {}

class WordLoaded extends WordState {
  final String targetWord;
  final String currentWord;
  final List<String> randomLetters;
  final List<String>? targetWordPics;

  WordLoaded(this.targetWord, this.currentWord, this.randomLetters,
      this.targetWordPics);
}

class WordCorrect extends WordState {}

class WordIncorrect extends WordState {}
