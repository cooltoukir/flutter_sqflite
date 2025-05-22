import 'package:get/get.dart';

import '../../data/repositories/quran_repository.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/surah_entity.dart';

class QuranController extends GetxController {
  final QuranRepository _repo = QuranRepository();
  var surahs = <SurahEntity>[].obs;
  var ayahs = <AyahEntity>[].obs;

  @override
  onInit() {
    super.onInit();
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    surahs.value = await _repo.getAllSurahs();
  }

  Future<void> loadAyahsBySurah(int surahNumber) async {
    ayahs.value = await _repo.getAyahsBySurah(surahNumber);
  }

  Future<void> insertAllSurahsFromApis() async {
    try {
      await _repo.fetchAndInsertAllSurahs();
      await loadSurahs();
      print("✅ All Surahs inserted successfully!");
    } catch (e) {
      print("❌ Error inserting Surahs: $e");
    }
  }

  // English to Bangla number converter
  String englishToBanglaNumber(String englishNumber) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    String banglaNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      final char = englishNumber[i];
      final index = english.indexOf(char);
      banglaNumber += index != -1 ? bangla[index] : char;
    }
    return banglaNumber;
  }
}
