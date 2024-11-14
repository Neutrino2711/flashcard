import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flashcard/database/database_helper.dart';

import '../models/flashcardset_model.dart';

part 'flashcardset_event.dart';
part 'flashcardset_state.dart';

class FlashcardsetBloc extends Bloc<FlashcardsetEvent, FlashcardsetState> {

  final DatabaseHelper databaseHelper = DatabaseHelper();

  FlashcardsetBloc() : super(FlashcardsetInitial()) {
      on<LoadFlashCardSets>(_onLoadFlashCardSets);
      on<AddFlashCardSets>(_onAddFlashCardSets);
  }


    Future<void> _onLoadFlashCardSets(LoadFlashCardSets event,Emitter<FlashcardsetState> emit) async {
      emit(FlashcardsetLoading());
    try {
      final flashcardsetsData = await databaseHelper.getFlashcardSets();
         final flashcardsets = flashcardsetsData.map((e) => FlashcardSet.fromMap(e)).toList();
      emit(FlashcardsetLoaded(flashcardsets: flashcardsets));
    
    } catch(e)
    {
      emit(FlashcardsetError(error: e.toString()));
    }
  }

  Future<void> _onAddFlashCardSets(AddFlashCardSets event,Emitter<FlashcardsetState> emit) async {
    try{
      await databaseHelper.insertFlashcardSet(event.flashcardSet.toMap());
      
      add(const LoadFlashCardSets()); 
    }
    catch(e)
    {
      emit(FlashcardsetError(error: e.toString()));
    }
  }
}
