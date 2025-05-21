import 'package:get/get.dart';

import '../../data/repositories/quran_repository.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/surah_entity.dart';

class QuranController extends GetxController {
  final QuranRepository _repo = QuranRepository();
  var surahs = <SurahEntity>[].obs;
  var ayahs = <AyahEntity>[].obs;

  Future<void> loadSurahs() async {
    surahs.value = await _repo.getAllSurahs();
  }

  Future<void> loadAyahsBySurah(int surahNumber) async {
    ayahs.value = await _repo.getAyahsBySurah(surahNumber);
  }
}
