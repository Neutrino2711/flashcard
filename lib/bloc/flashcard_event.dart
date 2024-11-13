part of 'flashcard_bloc.dart';



abstract class FlashcardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFlashcards extends FlashcardEvent {}

class AddFlashcard extends FlashcardEvent {
  final Flashcard flashcard;

  AddFlashcard(this.flashcard);

  @override
  List<Object> get props => [flashcard];
}

class UpdateFlashcard extends FlashcardEvent {
  final Flashcard flashcard;

  UpdateFlashcard(this.flashcard);

  @override
  List<Object> get props => [flashcard];
}

class DeleteFlashcard extends FlashcardEvent {
  final int id;

  DeleteFlashcard(this.id);

  @override
  List<Object> get props => [id];
}


