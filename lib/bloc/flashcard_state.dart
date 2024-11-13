part of 'flashcard_bloc.dart';

@immutable
sealed class FlashcardState {}

final class FlashcardInitial extends FlashcardState {}

class FlashcardLoading extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final List<Flashcard> flashcards;

  FlashcardLoaded(this.flashcards);

  List<Object> get props => [flashcards];
}

class FlashcardError extends FlashcardState {
  final String message;

  FlashcardError(this.message);


  List<Object> get props => [message];
}
