

class DocumentlistModel {
  final String? documentId;
  final String? documentName;
  final String? mandatory;
  final String? status;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  DocumentlistModel({
    this.documentId,
    this.documentName,
    this.mandatory,
    this.status,
    this.createdAt,
    this.modifiedAt,
  });

  factory DocumentlistModel.fromJson(Map<String, dynamic> json) {
    // Handling possible nulls in nested date/time fields
    DateTime? parseDate(dynamic dateField) {
      if (dateField == null) return null;
      if (dateField is String) return DateTime.tryParse(dateField);
      if (dateField is Map<String, dynamic> && dateField['date'] != null) {
        return DateTime.tryParse(dateField['date']);
      }
      return null;
    }

    return DocumentlistModel(
      documentId: json['documentId']?.toString(),
      documentName: json['documentName'] as String?,
      mandatory: json['mandatory']?.toString(),
      status: json['status'] as String?,
      createdAt: parseDate(json['created_at']),
      modifiedAt: parseDate(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'documentName': documentName,
      'mandatory': mandatory,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'modified_at': modifiedAt?.toIso8601String(),
    };
  }
}
