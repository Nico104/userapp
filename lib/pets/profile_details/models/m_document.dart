class Document {
  final int documentId;
  final int petProfileId;
  final String documentName;
  final String documentLink;

  Document(
    this.documentId,
    this.petProfileId,
    this.documentName,
    this.documentLink,
  );

  Document.fromJson(Map<String, dynamic> json)
      : documentId = json['document_id'],
        petProfileId = json['petProfile_id'],
        documentName = json['document_name'],
        documentLink = json['document_link'];
}
