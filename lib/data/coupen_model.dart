class CouponModel {
  final int couponId;
  final String discountType;
  final double discountValue;
  final double discountAmount;

  CouponModel({
    required this.couponId,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
  });

  // Factory constructor to create a CouponModel from JSON
  factory CouponModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return CouponModel(
      couponId: data['couponId'] ?? 0,
      discountType: data['discountType'] ?? '',
      discountValue: (data['discountValue'] ?? 0).toDouble(),
      discountAmount: (data['discountAmount'] ?? 0).toDouble(),
    );
  }

  // Convert to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'couponId': couponId,
      'discountType': discountType,
      'discountValue': discountValue,
      'discountAmount': discountAmount,
    };
  }
}
