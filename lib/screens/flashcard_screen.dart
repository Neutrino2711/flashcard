import 'dart:ffi';

import 'package:flashcard/bloc/flashcard_bloc.dart';
import 'package:flashcard/database/database_helper.dart';
import 'package:flashcard/screens/createflashcard_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../models/flashcard_model.dart';


class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashcardBloc()..add(LoadFlashcards(setId: 0)),
      child: FlashcardScreen(),
    );
  }
}

class FlashcardScreen extends StatelessWidget {

   void _showEditFlashcardDialog(BuildContext context, Flashcard flashcard) {
    final TextEditingController questionController = TextEditingController(text: flashcard.question);
    final TextEditingController answerController = TextEditingController(text: flashcard.answer);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Flashcard"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              TextField(
                controller: answerController,
                decoration: InputDecoration(labelText: 'Answer'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedFlashcard = Flashcard(
                  id: flashcard.id,
                  question: questionController.text,
                  answer: answerController.text,
                  setId: 0
                );

                // Dispatch the update event
                context.read<FlashcardBloc>().add(UpdateFlashcard(flashcard:  updatedFlashcard,setId: 0));
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flashcards"),
      // actions: [
      //   ElevatedButton(onPressed: (){
      //     context.read<FlashcardBloc>().add(LoadFlashcards(setId: 0));
      //   }, child: Text("Reload"))
      // ],
      ),
      
      body: BlocBuilder<FlashcardBloc, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashcardLoaded) {
            List<Flashcard> flashcards = state.flashcards;
           return Center(
  child: Builder(
  builder: (context) {
    if (flashcards.isEmpty) {
      return const Center(child: Text("No Flash Cards"));
    } else if (flashcards.length == 1) {
      return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onLongPress: () {
                  _showEditFlashcardDialog(context, flashcards[0]);
                },
                onDoubleTap: () {
                  context
                      .read<FlashcardBloc>()
                      .add(DeleteFlashcard(id: flashcards.first.id!, setId: 0));
                },
                child: FlipCard(
                  front: FlashcardView(
                    text: flashcards[0].question,
                    color: Colors.redAccent,
                  ),
                  back: FlashcardView(
                    text: flashcards[0].answer,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          );
    } else {
      return CardSwiper(
        cardBuilder: (context, index, x, y) {
          return GestureDetector(
            onLongPress: () {
              _showEditFlashcardDialog(context, flashcards[index]);
            },
            child: FlipCard(
              front: FlashcardView(
                text: flashcards[index].question,
                color: Colors.redAccent,
              ),
              back: FlashcardView(
                text: flashcards[index].answer,
                color: Colors.blueAccent,
              ),
            ),
          );
        },
        onSwipe: (previousIndex, currentIndex, direction) {
          if (direction == CardSwiperDirection.bottom) {
            context
                .read<FlashcardBloc>()
                .add(DeleteFlashcard(id: flashcards[currentIndex!].id!, setId: 0));
          }
          return true;
        },
        numberOfCardsDisplayed: 2,
        cardsCount: flashcards.length,
      );
    }
  },),);

          } else if (state is FlashcardError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No flashcards found"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlashCard() ));
        },
      ),
    );
  }
}




class FlashcardView extends StatelessWidget {
  final String text;
  final Color color;

  FlashcardView({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}