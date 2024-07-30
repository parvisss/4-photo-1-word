// event.dart
abstract class WordEvent {}

class GenerateTargetWord extends WordEvent {}

class AddLetter extends WordEvent {
  final String letter;
  AddLetter(this.letter);
}

class DeleteLetter extends WordEvent {}

class ClearWord extends WordEvent {}

class CheckWord extends WordEvent {}
