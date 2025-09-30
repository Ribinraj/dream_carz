class EditProfileModel {
  final String? fullName;
  final String? emailAddress;
  final String? pushToken;

  EditProfileModel({
    this.fullName,
    this.emailAddress,
    this.pushToken,
  });

  // Convert JSON → Dart object
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      fullName: json['fullName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      pushToken: json['pushToken'] as String?,
    );
  }

  // Convert Dart object → JSON (for API)
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'emailAddress': emailAddress,
      'pushToken': pushToken,
    };
  }
}
