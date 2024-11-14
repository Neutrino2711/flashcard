import 'package:bloc/bloc.dart';
import 'package:flashcard/database/database_helper.dart';
import 'package:flashcard/models/flashcard_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'flashcard_event.dart';
part 'flashcard_state.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {

  final DatabaseHelper databaseHelper = DatabaseHelper();

  FlashcardBloc() : super(FlashcardInitial()) {
  on<LoadFlashcards>(_onLoadFlashcards);
    on<AddFlashcard>(_onAddFlashcard);
    on<UpdateFlashcard>(_onUpdateFlashcard);
    on<DeleteFlashcard>(_onDeleteFlashcard);
  }

  Future<void> _onLoadFlashcards(
      LoadFlashcards event, Emitter<FlashcardState> emit) async {
    emit(FlashcardLoading());
    try {
      final flashcardsData = await databaseHelper.getFlashcardsBySet(event.setId);
      final flashcards = flashcardsData.map((e) => Flashcard.fromMap(e)).toList();
      emit(FlashcardLoaded(flashcards));
    } catch (e) {
      emit(FlashcardError("Failed to load flashcards"));
    }
  }

  Future<void> _onAddFlashcard(
      AddFlashcard event, Emitter<FlashcardState> emit) async {
    try {
      await databaseHelper.insertFlashcard(event.flashcard.toMap());
      
      add(LoadFlashcards(setId: event.setId)); // Reload the flashcards after adding
    } catch (e) {
      emit(FlashcardError("Failed to add flashcard"));
    }
  }

  Future<void> _onUpdateFlashcard(
      UpdateFlashcard event, Emitter<FlashcardState> emit) async {
    try {
      await databaseHelper.updateFlashcard(event.flashcard.toMap());
      add(LoadFlashcards(setId: event.setId)); // Reload the flashcards after updating
    } catch (e) {
      emit(FlashcardError("Failed to update flashcard"));
    }
  }

  Future<void> _onDeleteFlashcard(
      DeleteFlashcard event, Emitter<FlashcardState> emit) async {
    try {
      await databaseHelper.deleteFlashcard(event.id);
      add(LoadFlashcards(setId: event.setId)); // Reload the flashcards after deleting
    } catch (e) {
      emit(FlashcardError("Failed to delete flashcard"));
    }
  }
}
