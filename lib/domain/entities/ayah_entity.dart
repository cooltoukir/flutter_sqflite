class AyahEntity {
  final int number;
  final String text;
  final String pronunciationBn;
  final String translateBn;
  final String translateEn;
  final int numberInSurah;
  final int surahNumber;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final int sajda;

  const AyahEntity({
    required this.number,
    required this.text,
    required this.pronunciationBn,
    required this.translateBn,
    required this.translateEn,
    required this.numberInSurah,
    required this.surahNumber,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });
}
