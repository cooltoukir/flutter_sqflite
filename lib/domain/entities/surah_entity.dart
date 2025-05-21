class SurahEntity {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String bengaliName;
  final String bengaliNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final int words;
  final int chars;
  final String arabicAudio;
  final String arabicAudioSecondary;

  const SurahEntity({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.bengaliName,
    required this.bengaliNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.words,
    required this.chars,
    required this.arabicAudio,
    required this.arabicAudioSecondary,
  });
}
