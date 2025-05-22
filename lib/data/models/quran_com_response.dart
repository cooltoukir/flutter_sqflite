class QuranComSurah {
  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final int versesCount;
  final List<int> pages;
  final String translatedName;

  QuranComSurah({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  factory QuranComSurah.fromJson(Map<String, dynamic> json) {
    return QuranComSurah(
      id: json['id'],
      revelationPlace: json['revelation_place'],
      revelationOrder: json['revelation_order'],
      bismillahPre: json['bismillah_pre'],
      nameSimple: json['name_simple'],
      nameComplex: json['name_complex'],
      nameArabic: json['name_arabic'],
      versesCount: json['verses_count'],
      pages: List<int>.from(json['pages']),
      translatedName: json['translated_name']['name'],
    );
  }
}

class QuranComResponse {
  final List<QuranComSurah> chapters;

  QuranComResponse({required this.chapters});

  factory QuranComResponse.fromJson(Map<String, dynamic> json) {
    return QuranComResponse(
      chapters: List<QuranComSurah>.from(
        json['chapters'].map((x) => QuranComSurah.fromJson(x)),
      ),
    );
  }
}
