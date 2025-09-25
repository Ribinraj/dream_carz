class CategoriesModel {
  final String categoryId;
  final String fleetTypeId;
  final String categoryName;
  final String status;
  final String createdAt;
  final String modifiedAt;

  CategoriesModel({
    required this.categoryId,
    required this.fleetTypeId,
    required this.categoryName,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryId: json['categoryId'] ?? "",
      fleetTypeId: json['fleetTypeId'] ?? "",
      categoryName: json['categoryName'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] != null && json['created_at']['date'] != null
          ? json['created_at']['date'] ?? ""
          : "",
      modifiedAt: json['modified_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "fleetTypeId": fleetTypeId,
      "categoryName": categoryName,
      "status": status,
      "created_at": {"date": createdAt},
      "modified_at": modifiedAt,
    };
  }
}