class VerifyOtpmodel {
  final String customerId;
  final String otp;
  final String? fullName;
  final String? emailAddress;

  VerifyOtpmodel({
    required this.customerId,
    required this.otp,
    this.fullName,
    this.emailAddress,
  });

  // Convert Dart object to JSON (for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'otp': otp,
      if (fullName != null) 'fullName': fullName,
      if (emailAddress != null) 'emailAdddress': emailAddress, // keep same key spelling as API
    };
  }


}
