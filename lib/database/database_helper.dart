

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
        db.execute(
          'CREATE TABLE flashcard_sets(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)',
        );
        return db.execute(
          'CREATE TABLE flashcards(id INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT, answer TEXT, set_id INTEGER, FOREIGN KEY(set_id) REFERENCES flashcard_sets(id))',
        );
      },
      version: 1,
    );
  }

  
  Future<int> insertFlashcardSet(Map<String, dynamic> flashcardSet) async {
    final db = await database;
    return await db.insert('flashcard_sets', flashcardSet);
  }

  
  Future<List<Map<String, dynamic>>> getFlashcardSets() async {
    final db = await database;
    return await db.query('flashcard_sets');
  }

  
  Future<int> insertFlashcard(Map<String, dynamic> flashcard) async {
    final db = await database;
    return await db.insert('flashcards', flashcard);
  }

  
  Future<List<Map<String, dynamic>>> getFlashcardsBySet(int setId) async {
    final db = await database;
    print(db.query( 'flashcards',
      where: 'set_id = ?',
      whereArgs: [setId],));
    return await db.query(
      'flashcards',
      where: 'set_id = ?',
      whereArgs: [setId],
    );
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

  
  Future<int> deleteFlashcardSet(int id) async {
    final db = await database;
    
    await db.delete(
      'flashcards',
      where: 'set_id = ?',
      whereArgs: [id],
    );
    
    return await db.delete(
      'flashcard_sets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

