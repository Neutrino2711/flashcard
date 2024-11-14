part of 'flashcardset_bloc.dart';

sealed class FlashcardsetEvent extends Equatable {
  const FlashcardsetEvent();

  @override
  List<Object> get props => [];
}

class LoadFlashCardSets extends FlashcardsetEvent{

  LoadFlashCardSets();
}

class AddFlashCardSets extends FlashcardsetEvent{

  final FlashcardSet flashcardSet;

  AddFlashCardSets({required this.flashcardSet});

}