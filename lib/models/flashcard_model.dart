class Flashcard {
  final int? id;
  final String question;
  final String answer;
  final int setId;

  Flashcard({this.id, required this.question, required this.answer, required this.setId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'set_id': setId,
    };
  }

  static Flashcard fromMap(Map<String, dynamic> map) {
    print(map);
    return Flashcard(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      setId: map['set_id'],
    );
  }
}
