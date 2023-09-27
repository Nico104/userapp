class HealthIssue {
  final int healthIssueId;
  final int medicalInformationId;
  final String healthIssueType;
  int? linkedDocuemntId;
  String healthIssueName;

  HealthIssue(
    this.healthIssueId,
    this.medicalInformationId,
    this.healthIssueType,
    this.healthIssueName,
    this.linkedDocuemntId,
  );

  HealthIssue.fromJson(Map<String, dynamic> json)
      : healthIssueId = json['health_issue_id'],
        medicalInformationId = json['medicalInformationMedical_information_id'],
        healthIssueType = json['health_issue_type'].toString().toUpperCase(),
        healthIssueName = json['health_issue_name'],
        linkedDocuemntId = json['documentDocument_id'];

  Map<String, dynamic> toJson() => {
        'health_issue_id': healthIssueId,
        'health_issue_name': healthIssueName,
        'health_issue_type': healthIssueType,
        'medical_information_id': medicalInformationId,
      };
}
