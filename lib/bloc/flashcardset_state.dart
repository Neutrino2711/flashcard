part of 'flashcardset_bloc.dart';

sealed class FlashcardsetState extends Equatable {
  const FlashcardsetState();
  
  @override
  List<Object> get props => [];
}

final class FlashcardsetInitial extends FlashcardsetState {}

final class FlashcardsetLoading extends FlashcardsetState {}

final class FlashcardsetLoaded extends FlashcardsetState {
   final List<FlashcardSet> flashcardsets;

  FlashcardsetLoaded({required this.flashcardsets});
}

final class FlashcardsetError extends FlashcardsetState {
  final String error;

  FlashcardsetError({required this.error});
}
