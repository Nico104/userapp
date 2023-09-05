class Document {
  final int documentId;
  final int petProfileId;
  final String documentName;
  final String documentLink;
  // final String documentType;
  final String contentType;

  Document(
    this.documentId,
    this.petProfileId,
    this.documentName,
    this.documentLink,
    this.contentType,
    // this.documentType,
  );

  Document.fromJson(Map<String, dynamic> json)
      : documentId = json['document_id'],
        petProfileId = json['petProfile_id'],
        documentName = json['document_name'],
        documentLink = json['document_link'],
        // documentType = json['document_type'],
        contentType = json['content_type'];

  Map<String, dynamic> toJson() => {
        'document_id': documentId,
        'petProfile_id': petProfileId,
        'document_name': documentName,
        'document_link': documentLink,
      };

  Map<String, dynamic> toJsonWithDocumentType(String documentType) => {
        'document_id': documentId,
        'petProfile_id': petProfileId,
        'document_name': documentName,
        'document_link': documentLink,
        'document_type': documentType,
      };
}
