import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';

class MedicalInformation {
  final int medicalInformationId;
  final int petProfileId;
  List<HealthIssue> healthIssues;
  bool? sterilized;

  MedicalInformation(
    this.medicalInformationId,
    this.petProfileId,
    this.healthIssues,
  );

  MedicalInformation.fromJson(Map<String, dynamic> json)
      : medicalInformationId = json['medical_information_id'],
        petProfileId = json['petProfile_id'],
        healthIssues = json['health_issues'] != null
            ? (json['health_issues'] as List)
                .map((t) => HealthIssue.fromJson(t))
                .toList()
            : [],
        sterilized = json['sterilized'];

  Map<String, dynamic> toJson() => {
        'medical_information_id': medicalInformationId,
        'petProfile_id': petProfileId,
        'sterilized': sterilized,
      };
}
