class FlashcardSet {
  // final int? id;
  final String title;
  // final String description;

  FlashcardSet({required this.title});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'title': title,
      // 'description': description,
    };
  }

  static FlashcardSet fromMap(Map<String, dynamic> map) {
    return FlashcardSet(
      // id: map['id'],
      title: map['title'],
      // description: map['description'],
    );
  }
}
