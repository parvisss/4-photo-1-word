// bloc.dart
import 'dart:math';
import 'package:find_the_word_from_pics/bloc/word_event.dart';
import 'package:find_the_word_from_pics/bloc/word_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final List<String> wordsToFind = ["australia", "football", "music"];
  final Map<String, List<String>> mapwordsToFind = {
    "australia": [
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/800px-Flag_of_Australia_%28converted%29.svg.png",
      "https://upload.wikimedia.org/wikipedia/commons/e/ed/Australia_satellite_plane.jpg",
      "https://cdnuploads.aa.com.tr/uploads/Contents/2023/03/31/thumbs_b_c_2d02882d5c0f0fb50c702e62bcbf5441.jpg?v=235901",
      "https://ichef.bbci.co.uk/news/976/cpsprodpb/10A3C/production/_129365186_gettyimages-103455489.jpg",
    ],
    "football": [
      "https://upload.wikimedia.org/wikipedia/commons/1/1d/Football_Pallo_valmiina-cropped.jpg",
      "https://assets.teenvogue.com/photos/63e3e7beb504ab68f0f8760c/4:3/w_2664,h_1998,c_limit/GettyImages-1463476488.jpg",
      "https://library.sportingnews.com/styles/twitter_card_120x120/s3/2022-06/Real%20Madrid%20Barcelona%20crest%20logo%20badge%20El%20Clasico%20062322.jpg?itok=Q09me5cc",
      "https://i.pinimg.com/originals/0c/88/86/0c88866150bd320ea52c000aa78015e2.jpg",
    ],
    "music": [
      "https://capian.co/assets/images/uploads/blog/ckia8-music-lockdown-1fa0fb8b.jpg",
      "https://img.freepik.com/premium-photo/black-woman-uses-airphone-with-glasses_60312-812.jpg",
      "https://www.muztorg.ru/files/3fe/6f5/bx7/les/gkk/4w8/4gw/g4w/4/3fe6f5bx7lesgkk4w84gwg4w4.jpg",
      "https://www.muztorg.ru/files/3fe/6f5/bx7/les/gkk/4w8/4gw/g4w/4/3fe6f5bx7lesgkk4w84gwg4w4.jpg",
    ]
  };

  late String _targetWord;
  String _currentWord = "";
  bool isShuffle = true;
  late List<String> _randomLetters;
  List<String>? _targetWordPics = [];

  WordBloc() : super(WordInitial()) {
    on<GenerateTargetWord>((event, emit) => _onGenerateTargetWord(emit));
    on<AddLetter>((event, emit) => _onAddLetter(event, emit));
    on<DeleteLetter>((event, emit) => _onDeleteLetter(emit));
    on<ClearWord>((event, emit) => _onClearWord(emit));
    on<CheckWord>((event, emit) => _onCheckWord(emit));
  }

  void _onGenerateTargetWord(Emitter<WordState> emit) {
    final random = Random();
    _targetWord = wordsToFind[random.nextInt(wordsToFind.length)];
    _targetWordPics = mapwordsToFind[_targetWord];
    _randomLetters = _generateRandomLetters(_targetWord);
    emit(
      WordLoaded(_targetWord, _currentWord, _randomLetters, _targetWordPics),
    );
  }

  void _onAddLetter(AddLetter event, Emitter<WordState> emit) {
    _currentWord += event.letter;
    emit(
        WordLoaded(_targetWord, _currentWord, _randomLetters, _targetWordPics));
  }

  void _onDeleteLetter(Emitter<WordState> emit) {
    if (_currentWord.isNotEmpty) {
      _currentWord = _currentWord.substring(0, _currentWord.length - 1);
      emit(WordLoaded(
          _targetWord, _currentWord, _randomLetters, _targetWordPics));
    }
  }

  void _onClearWord(Emitter<WordState> emit) {
    _currentWord = "";
    emit(
      WordLoaded(_targetWord, _currentWord, _randomLetters, _targetWordPics),
    );
  }

  void _onCheckWord(Emitter<WordState> emit) {
    if (_currentWord.toLowerCase() == _targetWord.toLowerCase()) {
      emit(WordCorrect());
      _currentWord = "";
      _onGenerateTargetWord(emit);
    } else {
      emit(WordIncorrect());
    }
  }

  List<String> _generateRandomLetters(String word) {
    final random = Random();
    final allLetters =
        List<String>.generate(26, (index) => String.fromCharCode(index + 65));
    final selectedLetters = word.toUpperCase().split('');
    final additionalLetters = <String>{};

    while (additionalLetters.length < 14 - selectedLetters.length) {
      final letter = allLetters[random.nextInt(allLetters.length)];
      if (!selectedLetters.contains(letter) &&
          !additionalLetters.contains(letter)) {
        additionalLetters.add(letter);
      }
    }
    var combinedLetters = [...selectedLetters, ...additionalLetters];

    if (isShuffle) {
      combinedLetters.shuffle(random);
      isShuffle = false;
    }

    return combinedLetters;
  }
}
