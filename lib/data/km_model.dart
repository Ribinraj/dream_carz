class KmModel {
  final String kmId;
  final int? kmLimit; // parsed to int
  final String status;
  final String createdAt; // created_at.date
  final String modifiedAt;

  KmModel({
    required this.kmId,
    this.kmLimit,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory KmModel.fromJson(Map<String, dynamic> json) {
    return KmModel(
      kmId: (json['kmId'] ?? '').toString(),
      kmLimit: _toInt(json['kmLimit']),
      status: (json['status'] ?? '').toString(),
      createdAt: json['created_at'] != null && json['created_at']['date'] != null
          ? (json['created_at']['date'] ?? '').toString()
          : '',
      modifiedAt: (json['modified_at'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'kmId': kmId,
        'kmLimit': kmLimit?.toString(),
        'status': status,
        'created_at': {'date': createdAt},
        'modified_at': modifiedAt,
      };

  @override
  String toString() {
    return 'KmModel(kmId: $kmId, kmLimit: $kmLimit, status: $status)';
  }
}

/// Helper to robustly convert various input types into int
int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}