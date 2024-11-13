import 'package:flashcard/bloc/flashcard_bloc.dart';
import 'package:flashcard/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashcardBloc()..add(LoadFlashcards()),
      child: FlashcardScreen(),
    );
  }
}

class FlashcardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flashcards")),
      body: BlocBuilder<FlashcardBloc, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FlashcardLoaded) {
            return ListView.builder(
              itemCount: state.flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = state.flashcards[index];
                return ListTile(
                  title: Text(flashcard.question),
                  subtitle: Text(flashcard.answer),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Trigger update
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<FlashcardBloc>(context)
                              .add(DeleteFlashcard(flashcard.id!));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is FlashcardError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No flashcards found"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          
        },
      ),
    );
  }
}
