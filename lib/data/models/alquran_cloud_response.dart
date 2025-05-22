class AlQuranCloudSurah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  AlQuranCloudSurah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory AlQuranCloudSurah.fromJson(Map<String, dynamic> json) {
    return AlQuranCloudSurah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}

class AlQuranCloudResponse {
  final int code;
  final String status;
  final List<AlQuranCloudSurah> data;

  AlQuranCloudResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory AlQuranCloudResponse.fromJson(Map<String, dynamic> json) {
    return AlQuranCloudResponse(
      code: json['code'],
      status: json['status'],
      data: List<AlQuranCloudSurah>.from(
        json['data'].map((x) => AlQuranCloudSurah.fromJson(x)),
      ),
    );
  }
}
