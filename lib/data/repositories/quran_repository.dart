import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/surah_entity.dart';
import '../db/database_helper.dart';
import '../models/ayah_model.dart';
import '../models/surah_model.dart';

class QuranRepository {
  final dbHelper = DatabaseHelper();

  Future<List<SurahEntity>> getAllSurahs() async {
    final db = await dbHelper.database;
    final result = await db.query('surahs');
    return result.map((e) => SurahModel.fromMap(e)).toList();
  }

  Future<List<AyahEntity>> getAyahsBySurah(int surahNumber) async {
    final db = await dbHelper.database;
    final result = await db.query('ayahs', where: 'surahNumber = ?', whereArgs: [surahNumber]);
    return result.map((e) => AyahModel.fromMap(e)).toList();
  }
}
