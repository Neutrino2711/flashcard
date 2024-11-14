part of 'flashcard_bloc.dart';



abstract class FlashcardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFlashcards extends FlashcardEvent {
  final int setId;

  LoadFlashcards({required this.setId});
}

class AddFlashcard extends FlashcardEvent {
  final Flashcard flashcard;
  final int setId;

  AddFlashcard({required this.flashcard,required this.setId});

  @override
  List<Object> get props => [flashcard];
}

class UpdateFlashcard extends FlashcardEvent {
  final Flashcard flashcard;
  final int setId;

  UpdateFlashcard({required this.flashcard,required this.setId});

  @override
  List<Object> get props => [flashcard];
}

class DeleteFlashcard extends FlashcardEvent {
  final int id;
  final int setId;

  DeleteFlashcard({required this.id,required this.setId});

  @override
  List<Object> get props => [id];
}


