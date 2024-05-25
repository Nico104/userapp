import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';

class MedicalInformation {
  final int medicalInformationId;
  final int petProfileId;
  List<HealthIssue> healthIssues;
  bool? sterilized;
  String? breed;
  String? age;
  String? vaccinations;
  String? allergies;
  String? medications;
  String? chronicConditions;

  MedicalInformation(
    this.medicalInformationId,
    this.petProfileId,
    this.healthIssues,
    this.age,
    this.allergies,
    this.breed,
    this.chronicConditions,
    this.medications,
    this.sterilized,
    this.vaccinations,
  );

  MedicalInformation.fromJson(Map<String, dynamic> json)
      : medicalInformationId = json['medical_information_id'],
        petProfileId = json['petProfile_id'],
        healthIssues = json['health_issues'] != null
            ? (json['health_issues'] as List)
                .map((t) => HealthIssue.fromJson(t))
                .toList()
            : [],
        breed = json['breed'],
        age = json['age'],
        vaccinations = json['vaccinations'],
        allergies = json['allergies'],
        medications = json['medications'],
        chronicConditions = json['chronicConditions'],
        sterilized = json['sterilized'];

  Map<String, dynamic> toJson() => {
        'medical_information_id': medicalInformationId,
        'petProfile_id': petProfileId,
        'sterilized': sterilized,
        'breed': breed,
        'age': age,
        'vaccinations': vaccinations,
        'allergies': allergies,
        'medications': medications,
        'chronicConditions': chronicConditions,
      };
}
