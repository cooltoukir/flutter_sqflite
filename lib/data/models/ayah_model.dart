import '../../domain/entities/ayah_entity.dart';

class AyahModel extends AyahEntity {
  const AyahModel({
    required int number,
    required String text,
    required String pronunciationBn,
    required String translateBn,
    required String translateEn,
    required int numberInSurah,
    required int surahNumber,
    required int juz,
    required int manzil,
    required int page,
    required int ruku,
    required int hizbQuarter,
    required int sajda,
  }) : super(
    number: number,
    text: text,
    pronunciationBn: pronunciationBn,
    translateBn: translateBn,
    translateEn: translateEn,
    numberInSurah: numberInSurah,
    surahNumber: surahNumber,
    juz: juz,
    manzil: manzil,
    page: page,
    ruku: ruku,
    hizbQuarter: hizbQuarter,
    sajda: sajda,
  );

  factory AyahModel.fromMap(Map<String, dynamic> map) {
    return AyahModel(
      number: map['number'],
      text: map['text'],
      pronunciationBn: map['pronunciation_bn'],
      translateBn: map['translate_bn'],
      translateEn: map['translate_en'],
      numberInSurah: map['numberInSurah'],
      surahNumber: map['surahNumber'],
      juz: map['juz'],
      manzil: map['manzil'],
      page: map['page'],
      ruku: map['ruku'],
      hizbQuarter: map['hizbQuarter'],
      sajda: map['sajda'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
      'pronunciation_bn': pronunciationBn,
      'translate_bn': translateBn,
      'translate_en': translateEn,
      'numberInSurah': numberInSurah,
      'surahNumber': surahNumber,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
    };
  }
}
