import 'package:flashcard/models/flashcard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/flashcard_bloc.dart';

class CreateFlashCard extends StatelessWidget {
   CreateFlashCard({super.key});

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController setIdController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Create Post'),
        
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Post',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
             ,),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                      Flashcard flashCard = Flashcard(question: questionController.text, answer: answerController.text, setId: int.tryParse(setIdController.text)!);

                      context.read<FlashcardBloc>().add(AddFlashcard(flashcard: flashCard, setId: int.tryParse(setIdController.text)!));
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
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'question..',
                      border: InputBorder.none,
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
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: answerController,
                    // keyboardType: TextInputType.multiline,
                    // autofocus: true,
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'answer ..',
                      border: InputBorder.none,
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
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: setIdController,
                    // keyboardType: TextInputType.multiline,
                    // autofocus: true,
                    showCursor: true,
                    decoration: const InputDecoration(
                      hintText: 'set id..',
                      border: InputBorder.none,
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