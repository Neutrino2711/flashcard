
import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String text;
  final Color color;

   FlashcardView({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.5,
      width: MediaQuery.of(context).size.width*.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [ BoxShadow(
        color: Colors.black.withOpacity(0.2), 
        offset: const Offset(4, 4), 
        blurRadius: 8.0, 
        spreadRadius: 2.0, 
      ),],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: const TextStyle(
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