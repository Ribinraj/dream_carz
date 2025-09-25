class SearchModel {
  final String bookingFrom; // formatted "YYYY-MM-DD HH:mm:ss"
  final String bookingTo;   // formatted "YYYY-MM-DD HH:mm:ss"
  final int cityId;

  // 🔹 Optional filters
  final int? categoryId;
  final int? kmId;
  final List<int>? fuelId;         // multiple fuels
  final List<int>? transmissionId; // multiple transmission types
  final int? minimumHours;

  SearchModel({
    required this.bookingFrom,
    required this.bookingTo,
    required this.cityId,
    this.categoryId,
    this.kmId,
    this.fuelId,
    this.transmissionId,
    this.minimumHours,
  });

  /// Convert Dart object -> JSON for API request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "bookingFrom": bookingFrom,
      "bookingTo": bookingTo,
      "cityId": cityId,
    };

    if (categoryId != null) data["categoryId"] = categoryId;
    if (kmId != null) data["kmId"] = kmId;
    if (fuelId != null && fuelId!.isNotEmpty) data["fuelId"] = fuelId;
    if (transmissionId != null && transmissionId!.isNotEmpty) {
      data["transmissionId"] = transmissionId;
    }
    if (minimumHours != null) data["minimumHours"] = minimumHours;

    return data;
  }
}
