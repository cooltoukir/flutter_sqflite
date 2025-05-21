import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "app_database.db");
    print('Database path: $path');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE todos(
        taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE surahs (
        number INTEGER PRIMARY KEY,
        arabicName TEXT,
        englishName TEXT,
        englishNameTranslation TEXT,
        bengaliName TEXT,
        bengaliNameTranslation TEXT,
        revelationType TEXT,
        numberOfAyahs INTEGER,
        words INTEGER,
        chars INTEGER,
        arabicAudio TEXT,
        arabicAudioSecondary TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ayahs (
        number INTEGER PRIMARY KEY,
        text TEXT,
        pronunciation_bn TEXT,
        translate_bn TEXT,
        translate_en TEXT,
        numberInSurah INTEGER,
        surahNumber INTEGER,
        juz INTEGER,
        manzil INTEGER,
        page INTEGER,
        ruku INTEGER,
        hizbQuarter INTEGER,
        sajda INTEGER,
        FOREIGN KEY(surahNumber) REFERENCES surahs(number)
      )
    ''');
  }
}
