import '../../domain/entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  const SurahModel({
    required int number,
    required String name,
    required String englishName,
    required String englishNameTranslation,
    required String bengaliName,
    required String bengaliNameTranslation,
    required String revelationType,
    required String bengaliRevelationType,
    required int numberOfAyahs,
    required int words,
    required int chars,
    required String arabicAudio,
    required String arabicAudioSecondary,
  }) : super(
    number: number,
    name: name,
    englishName: englishName,
    englishNameTranslation: englishNameTranslation,
    bengaliName: bengaliName,
    bengaliNameTranslation: bengaliNameTranslation,
    revelationType: revelationType,
    bengaliRevelationType: bengaliRevelationType,
    numberOfAyahs: numberOfAyahs,
    words: words,
    chars: chars,
    arabicAudio: arabicAudio,
    arabicAudioSecondary: arabicAudioSecondary,
  );

  factory SurahModel.fromMap(Map<String, dynamic> map) {
    return SurahModel(
      number: map['number'],
      name: map['name'],
      englishName: map['englishName'],
      englishNameTranslation: map['englishNameTranslation'],
      bengaliName: map['bengaliName'],
      bengaliNameTranslation: map['bengaliNameTranslation'],
      revelationType: map['revelationType'],
      bengaliRevelationType: map['bengaliRevelationType'],
      numberOfAyahs: map['numberOfAyahs'],
      words: map['words'],
      chars: map['chars'],
      arabicAudio: map['arabicAudio'],
      arabicAudioSecondary: map['arabicAudioSecondary'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'bengaliName': bengaliName,
      'bengaliNameTranslation': bengaliNameTranslation,
      'revelationType': revelationType,
      'bengaliRevelationType': bengaliRevelationType,
      'numberOfAyahs': numberOfAyahs,
      'words': words,
      'chars': chars,
      'arabicAudio': arabicAudio,
      'arabicAudioSecondary': arabicAudioSecondary,
    };
  }
}
