import 'package:flutter_sqflite/data/models/al_quran_cloud_ar_bn_en_response.dart';
import 'package:sqflite/sqflite.dart';

import '../../const/bengali_quran_data.dart';
import '../../const/full_quran_data.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/surah_entity.dart';
import '../db/database_helper.dart';
import '../models/alquran_cloud_response.dart';
import '../models/ayah_model.dart';
import '../models/quran_com_response.dart';
import '../models/surah_model.dart';
import 'package:dio/dio.dart';

class QuranRepository {
  final dbHelper = DatabaseHelper();
  final Dio _dio = Dio();

  Future<List<SurahEntity>> getAllSurahs() async {
    final db = await dbHelper.database;
    final result = await db.query('surahs');
    return result.map((e) => SurahModel.fromMap(e)).toList();
  }

  Future<SurahEntity?> getSurahByNumber(int surahNumber) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'surahs',
      where: 'number = ?',
      whereArgs: [surahNumber],
    );

    if (result.isNotEmpty) {
      return SurahModel.fromMap(result.first);
    } else {
      return null; // Surah not found
    }
  }

  Future<List<AyahEntity>> getAyahsBySurah(int surahNumber) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'ayahs',
      where: 'surahNumber = ?',
      whereArgs: [surahNumber],
    );
    return result.map((e) => AyahModel.fromMap(e)).toList();
  }

  Future<void> fetchAndInsertAllSurahs() async {
    try {
      final alQuranCloud = await fetchSurahsFromAlQuranCloud();
      final quranCom = await fetchSurahsFromQuranCom();

      final bengaliData = BengaliQuranData.surahData;
      final fullQuranData = FullQuranData.full;

      await insertAllSurahs(
        cloudResponse: alQuranCloud,
        quranComResponse: quranCom,
        bengaliData: bengaliData,
        fullQuranData: fullQuranData,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<AlQuranCloudResponse> fetchSurahsFromAlQuranCloud() async {
    const url = 'http://api.alquran.cloud/v1/surah';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return AlQuranCloudResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch from AlQuranCloud: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching from AlQuranCloud: $e');
    }
  }

  Future<QuranComResponse> fetchSurahsFromQuranCom() async {
    const url = 'https://api.quran.com/api/v4/chapters?language=bn';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return QuranComResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch from Quran.com: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching from Quran.com: $e');
    }
  }

  Future<void> insertAllSurahs({
    required AlQuranCloudResponse cloudResponse,
    required QuranComResponse quranComResponse,
    required Map<int, Map<String, dynamic>> bengaliData,
    required List<Map<String, dynamic>> fullQuranData,
  }) async {
    for (var surah in cloudResponse.data) {
      final number = surah.number;

      final bengali = bengaliData[number];
      final full = fullQuranData.firstWhere((e) => e["number"] == number);
      final quranCom = quranComResponse.chapters.firstWhere(
        (c) => c.id == number,
      );

      final surahModel = SurahModel(
        number: number,
        name: surah.name,
        englishName: surah.englishName,
        englishNameTranslation: surah.englishNameTranslation,
        bengaliName: bengali?['name_bangla'] ?? '',
        bengaliNameTranslation: quranCom.translatedName,
        revelationType: surah.revelationType,
        bengaliRevelationType: bengali?['revelation_type'] ?? '',
        numberOfAyahs: surah.numberOfAyahs,
        words: full["words"] ?? 0,
        chars: full["chars"] ?? 0,
        arabicAudio:
            'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$number.mp3',
        arabicAudioSecondary:
            'https://download.quranicaudio.com/qdc/mishari_al_afasy/murattal/$number.mp3',
      );

      await insertSurah(surahModel); // Your DB insert method
    }
  }

  Future<void> insertSurah(SurahModel surah) async {
    final db = await dbHelper.database;
    await db.insert(
      'surahs',
      surah.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // replaces existing if number is duplicate
    );
  }

  Future<void> fetchAndInsertAyahsBySurah({required int surahNumber}) async {
    try {
      final alQuranCloudArBnEnResponse = await fetchAyahsFromAlQuranCloud(
        surahNumber: surahNumber,
      );

      final fullQuranData = FullQuranData.full;

      await insertAyahsBySurah(
        alQuranCloudArBnEnResponse: alQuranCloudArBnEnResponse,
        fullQuranData: fullQuranData,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<AlQuranCloudArBnEnResponse> fetchAyahsFromAlQuranCloud({
    required int? surahNumber,
  }) async {
    final url =
        'https://api.alquran.cloud/v1/surah/$surahNumber/editions/quran-uthmani,bn.bengali,en.sahih';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return AlQuranCloudArBnEnResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to fetch from AlQuranCloud: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching from AlQuranCloud: $e');
    }
  }

  Future<void> insertAyahsBySurah({
    required AlQuranCloudArBnEnResponse alQuranCloudArBnEnResponse,
    required List<Map<String, dynamic>> fullQuranData,
  }) async {
    final arabic = alQuranCloudArBnEnResponse.data[0];
    final bengali = alQuranCloudArBnEnResponse.data[1];
    final english = alQuranCloudArBnEnResponse.data[2];

    final surahNumber = arabic.number;
    final full = fullQuranData.firstWhere((e) => e["number"] == surahNumber);
    final List<Map<String, dynamic>> fullAyahs =
        List<Map<String, dynamic>>.from(full["ayahs"]);

    for (int i = 0; i < arabic.ayahs.length; i++) {
      final ar = arabic.ayahs[i];
      final bn = bengali.ayahs[i];
      final en = english.ayahs[i];
      final fullAyah = fullAyahs.firstWhere((a) => a["number"] == ar.number);

      final ayahModel = AyahModel(
        number: ar.number,
        text: ar.text,
        pronunciationBn: fullAyah["pronunciation_bn"],
        translateBn: bn.text,
        translateEn: en.text,
        numberInSurah: ar.numberInSurah,
        surahNumber: surahNumber,
        juz: ar.juz,
        manzil: ar.manzil,
        page: ar.page,
        ruku: ar.ruku,
        hizbQuarter: ar.hizbQuarter,
        sajda: parseSajda(ar.sajda),
      );

      await insertAyah(ayahModel);
    }
  }

  Future<void> insertAyah(AyahModel ayah) async {
    final db = await dbHelper.database;
    await db.insert(
      'ayahs',
      ayah.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // replaces existing if number is duplicate
    );
  }

  int parseSajda(dynamic sajda) {
    if (sajda is bool) {
      return sajda ? 1 : 0;
    } else if (sajda is Map<String, dynamic>) {
      // If it's a Map, you can decide how to interpret it.
      // For example, treat recommended or obligatory as sajda = 1
      return (sajda['recommended'] == true || sajda['obligatory'] == true)
          ? 1
          : 0;
    } else {
      return 0;
    }
  }
}
