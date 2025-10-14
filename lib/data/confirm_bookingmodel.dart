class ConfirmBookingmodel {
  final String bookingFrom;
  final String bookingTo;
  final int modelId;
  final int cityId;
  final String fulfillment;

  final String? couponCode;
  final String? deliveryArea;
  final String? deliveryAddress;
  final String? deliveryContactName;
  final String? deliveryContactMobile;

  ConfirmBookingmodel({
    // required fields
    required this.bookingFrom,
    required this.bookingTo,
    required this.modelId,
    required this.cityId,
    required this.fulfillment,
    // optional fields
    this.couponCode,
    this.deliveryArea,
    this.deliveryAddress,
    this.deliveryContactName,
    this.deliveryContactMobile,
  });

  /// Convert this object to JSON (for API request)
  Map<String, dynamic> toJson() {
    return {
      'bookingFrom': bookingFrom,
      'bookingTo': bookingTo,
      'modelId': modelId,
      'cityId': cityId,
      'fulfillment': fulfillment,
      if (couponCode != null) 'couponCode': couponCode,
      if (deliveryArea != null) 'deliveryArea': deliveryArea,
      if (deliveryAddress != null) 'deliveryAddress': deliveryAddress,
      if (deliveryContactName != null) 'deliveryContactName': deliveryContactName,
      if (deliveryContactMobile != null) 'deliveryContactMobile': deliveryContactMobile,
    };
  }

  /// Optional: create an object from JSON (useful for responses)
  factory ConfirmBookingmodel.fromJson(Map<String, dynamic> json) {
    return ConfirmBookingmodel(
      bookingFrom: json['bookingFrom'] ?? '',
      bookingTo: json['bookingTo'] ?? '',
      modelId: json['modelId'] ?? 0,
      cityId: json['cityId'] ?? 0,
      fulfillment: json['fulfillment'] ?? '',
      couponCode: json['couponCode'],
      deliveryArea: json['deliveryArea'],
      deliveryAddress: json['deliveryAddress'],
      deliveryContactName: json['deliveryContactName'],
      deliveryContactMobile: json['deliveryContactMobile'],
    );
  }
}
