class UploadDocumentmodel {
  final int? bookingId;
  final List<DocumentFile>? documents;

  UploadDocumentmodel({
    this.bookingId,
    this.documents,
  });

  factory UploadDocumentmodel.fromJson(Map<String, dynamic> json) {
    return UploadDocumentmodel(
      bookingId: json['bookingId'] as int?,
      documents: (json['documents'] as List?)
          ?.map((e) => DocumentFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'documents': documents?.map((e) => e.toJson()).toList(),
    };
  }
}

class DocumentFile {
  final int? documentId;
  final String? fileName;
  final String? fileBase64;

  DocumentFile({
    this.documentId,
    this.fileName,
    this.fileBase64,
  });

  factory DocumentFile.fromJson(Map<String, dynamic> json) {
    return DocumentFile(
      documentId: json['documentId'] as int?,
      fileName: json['fileName'] as String?,
      fileBase64: json['fileBase64'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'fileName': fileName,
      'fileBase64': fileBase64,
    };
  }
}
