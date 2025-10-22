class BannerDataModel {
  final String bannerId;
  final String fileName;
  final String file;
  final CreatedAt createdAt;
  final String modifiedAt;

  BannerDataModel({
    required this.bannerId,
    required this.fileName,
    required this.file,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory BannerDataModel.fromJson(Map<String, dynamic> json) {
    return BannerDataModel(
      bannerId: json['bannerId'] ?? '',
      fileName: json['fileName'] ?? '',
      file: json['file'] ?? '',
      createdAt: CreatedAt.fromJson(json['created_at']),
      modifiedAt: json['modified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bannerId': bannerId,
      'fileName': fileName,
      'file': file,
      'created_at': createdAt.toJson(),
      'modified_at': modifiedAt,
    };
  }
}

class CreatedAt {
  final String date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date'] ?? '',
      timezoneType: json['timezone_type'] ?? 0,
      timezone: json['timezone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timezone_type': timezoneType,
      'timezone': timezone,
    };
  }
}