
class ProfileModel {
  final String customerId;
  final String fullName;
  final String mobileNumber;
  final String emailAddress;
  final String? pushToken;
  final String status;

  ProfileModel({
    required this.customerId,
    required this.fullName,
    required this.mobileNumber,
    required this.emailAddress,
    this.pushToken,
    required this.status,
  });

  // Factory constructor for creating a new ProfileModel instance from a map
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      customerId: json['customerId']?.toString() ?? '',
      fullName: json['fullName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      emailAddress: json['emailAdddress'] ?? '', // typo handled from API
      pushToken: json['pushToken'], // nullable
      status: json['status'] ?? '',
    );
  }

  // Method to convert ProfileModel instance back to JSON map
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'emailAdddress': emailAddress, // keep API field spelling
      'pushToken': pushToken,
      'status': status,
    };
  }
}

