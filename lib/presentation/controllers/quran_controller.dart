import 'package:get/get.dart';

import '../../data/repositories/quran_repository.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/surah_entity.dart';

class QuranController extends GetxController {
  final QuranRepository _repo = QuranRepository();
  var surahs = <SurahEntity>[].obs;
  final Rxn<SurahEntity> selectedSurah = Rxn<SurahEntity>();
  var ayahs = <AyahEntity>[].obs;
  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    surahs.value = await _repo.getAllSurahs();
  }

  Future<void> loadSurahByNumber(int surahNumber) async {
    try {
      selectedSurah.value = await _repo.getSurahByNumber(surahNumber);
    } catch (e) {
      print("❌ Error loading surah: $e");
    }
  }

  Future<void> loadAyahsBySurah(int surahNumber) async {
    ayahs.value = await _repo.getAyahsBySurah(surahNumber);
  }

  Future<void> insertAllSurahsFromApis() async {
    try {
      // await _repo.fetchAndInsertAllSurahs();
      await loadSurahs();
      print("✅ All Surahs inserted successfully!");
    } catch (e) {
      print("❌ Error inserting Surahs: $e");
    }
  }

  Future<void> insertAyahsBySurahFromApis({required int surahNumber}) async {
    try {
      isLoading.value = true;

      // for (int surahNumber2 = surahNumber; surahNumber2 <= 114; surahNumber2++) {
      //   await _repo.fetchAndInsertAyahsBySurah(surahNumber: surahNumber2);
      // }

      // await _repo.fetchAndInsertAyahsBySurah(surahNumber: surahNumber);
      await loadAyahsBySurah(surahNumber);
      print("✅ All Ayahs inserted successfully!");
    } catch (e) {
      print("❌ Error inserting Ayahs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // English to Bengali number converter
  String englishToBengaliNumber(String englishNumber) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const bengali = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    String bengaliNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      final char = englishNumber[i];
      final index = english.indexOf(char);
      bengaliNumber += index != -1 ? bengali[index] : char;
    }
    return bengaliNumber;
  }
}
