import 'package:flashcard/database/database_helper.dart';
import 'package:flutter/material.dart';


import 'models/flashcard_model.dart';
import 'screens/flashcard_screen.dart';

void main() async {
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FlashcardApp(),
    );
  }
}


// class FlashcardApp extends StatefulWidget {
//   @override
//   _FlashcardAppState createState() => _FlashcardAppState();
// }

// class _FlashcardAppState extends State<FlashcardApp> {
//   final DatabaseHelper dbHelper = DatabaseHelper();
//   List<Flashcard> flashcards = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFlashcards();
//   }

//   Future<void> _loadFlashcards() async {
//     final data = await dbHelper.getFlashcards();
//     setState(() {
//       flashcards = data.map((e) => Flashcard.fromMap(e)).toList();
//     });
//   }

//   Future<void> _addFlashcard(String question, String answer) async {
//     final flashcard = Flashcard(question: question, answer: answer);
//     await dbHelper.insertFlashcard(flashcard.toMap());
//     _loadFlashcards();
//   }

//   Future<void> _deleteFlashcard(int id) async {
//     await dbHelper.deleteFlashcard(id);
//     _loadFlashcards();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flashcard App")),
//       body: ListView.builder(
//         itemCount: flashcards.length,
//         itemBuilder: (context, index) {
//           final flashcard = flashcards[index];
//           return ListTile(
//             title: Text(flashcard.question),
//             subtitle: Text("Tap to view answer"),
//             onTap: () => showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 content: Text(flashcard.answer),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("OK"),
//                   ),
//                 ],
//               ),
//             ),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => _deleteFlashcard(flashcard.id!),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           // Add flashcard via a form or directly for testing purposes
//           _addFlashcard("What is Flutter?", "A UI toolkit for natively compiled apps.");
//         },
//       ),
//     );
//   }
// }

