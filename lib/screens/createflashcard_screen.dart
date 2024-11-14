import 'package:flashcard/models/flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/flashcard_bloc.dart';

class CreateFlashCard extends StatelessWidget {
   CreateFlashCard({super.key,required this.setId});

  final int setId;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController setIdController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        // title: Text('Create Post'),
      backgroundColor: const Color(0xFF242730),
      foregroundColor: Colors.white,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Add',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
             ,),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                      Flashcard flashCard = Flashcard(question: questionController.text, answer: answerController.text, setId: setId);

                      context.read<FlashcardBloc>().add(AddFlashcard(flashcard: flashCard, setId: setId));
                      // Clear the fields and close the modal
                      setIdController.clear();
                      questionController.clear();
                      answerController.clear();
                    
                    // context.read<PostListBloc>().add(GetPostListEvent());
                     Navigator.pop(context);
              }
              else 
              {
                print("error");
              }
    
             
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scaffold(
             backgroundColor: Color(0xFF242730),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: questionController,
                    // keyboardType: TextInputType.multiline,
                    // autofocus: true,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'Question',
                       border: OutlineInputBorder(
                          // Adds border around the TextFormField
                          borderSide: BorderSide(
                            color: Colors.transparent
                          ),
      borderRadius: BorderRadius.all(Radius.circular(10)), // Optional: round the corners
    ),),
                      
                    // maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required!!';
                      }
                      return null;
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: answerController,
                    // keyboardType: TextInputType.multiline,
                    // autofocus: true,
                     style: TextStyle(
                      color: Colors.white
                    ),
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'Answer',
                      
                       border: OutlineInputBorder(  // Adds border around the TextFormField
      borderRadius: BorderRadius.all(Radius.circular(10)), // Optional: round the corners
    ),
                    ),
                      
                    // maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required!!';
                      }
                      return null;
                    },
                  ),
                ),
                
              ],
            ),
          ),
        
        ),
      ),
    );}
}