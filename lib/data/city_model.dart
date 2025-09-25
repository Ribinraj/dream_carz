class CityModel {
  final String cityId;
  final String name;
  final String status;
  final String createdAt;
  final String modifiedAt;

  CityModel({
    required this.cityId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['cityId'] ?? "",
      name: json['name'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] != null && json['created_at']['date'] != null
          ? json['created_at']['date'] ?? ""
          : "",
      modifiedAt: json['modified_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cityId": cityId,
      "name": name,
      "status": status,
      "created_at": {"date": createdAt},
      "modified_at": modifiedAt,
    };
  }
}
