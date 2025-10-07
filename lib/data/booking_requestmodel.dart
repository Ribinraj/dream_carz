class BookingRequestmodel {
  String bookingFrom;
  String bookingTo;
  int modelId;
  int cityId;
  int kmId;

  BookingRequestmodel({
    required this.bookingFrom,
    required this.bookingTo,
    required this.modelId,
    required this.cityId,
    required this.kmId,
  });

  Map<String, dynamic> toJson() => {
        "bookingFrom": bookingFrom,
        "bookingTo": bookingTo,
        "modelId": modelId,
        "cityId": cityId,
        "kmId": kmId,
      };
}
