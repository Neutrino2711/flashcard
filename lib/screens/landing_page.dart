import 'package:flashcard/bloc/flashcard_bloc.dart';
import 'package:flashcard/screens/flashcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/flashcardset_bloc.dart';
import '../models/flashcardset_model.dart';
import '../bloc/flashcard_bloc.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final List<String> flashcardSets = [
    'Set 1',
    'Set 2',
    'Set 3'
  ]; // Example sets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242730),
      appBar: AppBar(title:const Text('FlashCard Sets',
      style: TextStyle(
        color: Colors.white
      ),
      ),
      backgroundColor: const Color(0xFF242730),
      ),
      body: BlocBuilder<FlashcardsetBloc, FlashcardsetState>(
        builder: (context, state) {
          if(state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is FlashcardsetLoaded)
          {
            final setlists = state.flashcardsets;
               return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width*.65,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: setlists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            
                            context.read<FlashcardBloc>().add(LoadFlashcards(setId: index));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashcardScreen(setId: index,),
                              ),
                            );
                            
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*.65,
                            child: Card(
                              elevation: 20.0,
                              shadowColor: Color(35184217),
                              color: Color(0xFF354145),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(child: Text(setlists[index].title,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.cyanAccent
                              ),
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
               const   Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: Text(
                "Welcome!\n"
                "1) Swipe down to delete a flashcard. If only one flashcard remains, double tap to delete.\n"
                "2) To edit a flashcard, press and hold on the card, make your changes, and then save it.\n"
                "3) To create a new set, use the 'Add' button on this page. To add a new flashcard, use the 'Add' button on the flashcard page.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0, // Optional: Customize font size
                  fontWeight: FontWeight.w400, // Optional: Customize font weight
                ),
              )
              
                  )
              
                ],
              ),
            ),
          );

          }
       
         return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
           String flashcardSetTitle = "";
              showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF242730),
          title: const Text('Enter Flashcard Set Title',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Flashcard Set Title',
            
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: (value) {
              flashcardSetTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                
                Navigator.of(context).pop(flashcardSetTitle);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
               
                context.read<FlashcardsetBloc>().add(AddFlashCardSets(flashcardSet: FlashcardSet(title: flashcardSetTitle)));
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

   
   
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
