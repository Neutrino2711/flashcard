part of 'flashcardset_bloc.dart';

sealed class FlashcardsetEvent extends Equatable {
  const FlashcardsetEvent();

  @override
  List<Object> get props => [];
}

class LoadFlashCardSets extends FlashcardsetEvent{

  const LoadFlashCardSets();
}

class AddFlashCardSets extends FlashcardsetEvent{

  final FlashcardSet flashcardSet;

 const AddFlashCardSets({required this.flashcardSet});

}