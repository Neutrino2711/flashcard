import 'dart:ffi';

import 'package:flashcard/bloc/flashcard_bloc.dart';
import 'package:flashcard/database/database_helper.dart';
import 'package:flashcard/screens/createflashcard_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../models/flashcard_model.dart';
import '../widgets/flashcard.dart';



class FlashcardScreen extends StatelessWidget {

  const FlashcardScreen({required this.setId});

    final int setId;

   void _showEditFlashcardDialog(BuildContext context, Flashcard flashcard) {
    final TextEditingController questionController = TextEditingController(text: flashcard.question);
    final TextEditingController answerController = TextEditingController(text: flashcard.answer);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF242730),
          title: Text("Edit Flashcard",
          style: TextStyle(
            color: Colors.white,
          ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: questionController,
                decoration: InputDecoration(labelText: 'Question'),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.white
                ),
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
                  setId: setId
                );

                // Dispatch the update event
                context.read<FlashcardBloc>().add(UpdateFlashcard(flashcard:  updatedFlashcard,setId: setId));
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
      backgroundColor: Color(0xFF242730),
      appBar: AppBar(
        backgroundColor: Color(0xFF242730),
        foregroundColor: Colors.white,
        title: Text("Flashcards",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
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
      return const Center(child: Text("No Flash Cards",
      style: TextStyle(
        color: Colors.white
      ),
      ));
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
                      .add(DeleteFlashcard(id: flashcards.first.id!, setId: setId));
                },
                child: FlipCard(
                  front: FlashcardView(
                    text: flashcards[0].question,
                    color: Colors.amberAccent,
                    
                  ),
                  back: FlashcardView(
                    text: flashcards[0].answer,
                    color: Colors.cyanAccent,
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
                color: Colors.amberAccent,
              ),
              back: FlashcardView(
                text: flashcards[index].answer,
                color: Colors.cyanAccent,
              ),
            ),
          );
        },
        onSwipe: (previousIndex, currentIndex, direction) {
          if (direction == CardSwiperDirection.bottom) {
            context
                .read<FlashcardBloc>()
                .add(DeleteFlashcard(id: flashcards[previousIndex].id!, setId: setId));

            ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Flashcard with ID ${flashcards[previousIndex].id} deleted'),
        duration: const Duration(seconds: 2), // Duration for which the Snackbar will be visible
      ),
    );
               
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
            Navigator.push(context,MaterialPageRoute(builder: (context) => CreateFlashCard(setId: setId,) ));
        },
      ),
    );
  }
}



