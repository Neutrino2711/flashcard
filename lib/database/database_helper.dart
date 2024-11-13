import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'flashcards.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE flashcards(id INTEGER PRIMARY KEY, question TEXT, answer TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertFlashcard(Map<String, dynamic> flashcard) async {
    final db = await database;
    return await db.insert('flashcards', flashcard);
  }

  Future<List<Map<String, dynamic>>> getFlashcards() async {
    final db = await database;
    return await db.query('flashcards');
  }

  Future<int> updateFlashcard(Map<String, dynamic> flashcard) async {
    final db = await database;
    return await db.update(
      'flashcards',
      flashcard,
      where: 'id = ?',
      whereArgs: [flashcard['id']],
    );
  }

  Future<int> deleteFlashcard(int id) async {
    final db = await database;
    return await db.delete(
      'flashcards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
