import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../c_component_padding.dart';
import '../../../c_one_line_simple_input.dart';
import '../../../c_pet_gender.dart';
import '../../../models/m_pet_profile.dart';
import '../../../models/medical/m_medical_information.dart';
import '../../../widgets/two_options_button.dart';
import 'health_issues/health_issues_list.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({
    super.key,
    required this.petProfileDetails,
    // required this.setGender,
  });

  @override
  State<MedicalPage> createState() => _MedicalPageState();

  final PetProfileDetails petProfileDetails;
  // final void Function(Gender) setGender;
}

class _MedicalPageState extends State<MedicalPage> {
  late Future<MedicalInformation> future;

  @override
  void initState() {
    super.initState();
    future = getMedicalInformation(widget.petProfileDetails.profileId);
  }

  void _refreshMedicalInformation() {
    setState(() {
      future = getMedicalInformation(widget.petProfileDetails.profileId);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomNicoScrollView(
        title: Text("Medical Information"),
        body: FutureBuilder(
          future: future,
          builder: (BuildContext context,
              AsyncSnapshot<MedicalInformation> snapshot) {
            if (snapshot.hasData) {
              MedicalInformation medicalInformation = snapshot.data!;
              return Column(
                children: [
                  SizedBox(height: 42),
                  PaddingComponent(
                    child: TwoOptionButton(
                      activeColorOption1: HexColor("8be28b"),
                      inactiveColorOption1: Colors.black.withOpacity(0.1),
                      activeColorOption2: HexColor("ff6961"),
                      inactiveColorOption2: Colors.black.withOpacity(0.1),
                      title: "Is Tabo Sterilized?",
                      activeOption: medicalInformation.sterilized == true
                          ? ActiveOption.option1
                          : medicalInformation.sterilized == false
                              ? ActiveOption.option2
                              : ActiveOption.inactive,
                      optionLabel1: "Yes",
                      optionLabel2: "No",
                      onTap: (val) {
                        if (val == 0) {
                          medicalInformation.sterilized = null;
                        } else if (val == 1) {
                          medicalInformation.sterilized = true;
                        } else if (val == 2) {
                          medicalInformation.sterilized = false;
                        }

                        updateMedicalInformation(medicalInformation);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 0.5,
                      height: 0,
                    ),
                    padding: EdgeInsets.all(16 + 8),
                  ),
                  PaddingComponent(
                    child: HealthIssueList(
                      list: medicalInformation.healthIssues
                          .where((element) =>
                              element.healthIssueType.toLowerCase() ==
                              "allergies")
                          .toList(),
                      title: "Allergies",
                      petProfileId: widget.petProfileDetails.profileId,
                      refreshHealthIssues: () {
                        _refreshMedicalInformation();
                      },
                      newName: "New Allergy",
                      newType: "allergies",
                      medicalInformationId: snapshot.data!.medicalInformationId,
                    ),
                  ),
                  PaddingComponent(
                    child: HealthIssueList(
                      list: medicalInformation.healthIssues
                          .where((element) =>
                              element.healthIssueType.toLowerCase() ==
                              "medication")
                          .toList(),
                      title: "Medication",
                      petProfileId: widget.petProfileDetails.profileId,
                      refreshHealthIssues: () {
                        _refreshMedicalInformation();
                      },
                      newName: "New Medication",
                      newType: "medication",
                      medicalInformationId: snapshot.data!.medicalInformationId,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                "error loading version",
                style: Theme.of(context).textTheme.labelSmall,
              );
            } else {
              //Loading
              return Text(
                "Loading Version",
                style: Theme.of(context).textTheme.labelSmall,
              );
            }
          },
        ),
        onScroll: () {},
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Information"),
      ),
      body: FutureBuilder(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<MedicalInformation> snapshot) {
          if (snapshot.hasData) {
            MedicalInformation medicalInformation = snapshot.data!;
            return ListView(
              children: [
                PaddingComponent(
                  child: TwoOptionButton(
                    activeColorOption1: HexColor("8be28b"),
                    inactiveColorOption1: Colors.black.withOpacity(0.1),
                    activeColorOption2: HexColor("ff6961"),
                    inactiveColorOption2: Colors.black.withOpacity(0.1),
                    title: "Is Tabo Sterilized?",
                    activeOption: medicalInformation.sterilized == true
                        ? ActiveOption.option1
                        : medicalInformation.sterilized == false
                            ? ActiveOption.option2
                            : ActiveOption.inactive,
                    optionLabel1: "Yes",
                    optionLabel2: "No",
                    onTap: (val) {
                      if (val == 0) {
                        medicalInformation.sterilized = null;
                      } else if (val == 1) {
                        medicalInformation.sterilized = true;
                      } else if (val == 2) {
                        medicalInformation.sterilized = false;
                      }

                      updateMedicalInformation(medicalInformation);
                      setState(() {});
                    },
                  ),
                ),
                PaddingComponent(
                  child: HealthIssueList(
                    list: medicalInformation.healthIssues
                        .where((element) =>
                            element.healthIssueType.toLowerCase() ==
                            "allergies")
                        .toList(),
                    title: "Allergies",
                    petProfileId: widget.petProfileDetails.profileId,
                    refreshHealthIssues: () {
                      _refreshMedicalInformation();
                    },
                    newName: "New Allergy",
                    newType: "allergies",
                    medicalInformationId: snapshot.data!.medicalInformationId,
                  ),
                ),
                PaddingComponent(
                  child: HealthIssueList(
                    list: medicalInformation.healthIssues
                        .where((element) =>
                            element.healthIssueType.toLowerCase() ==
                            "medication")
                        .toList(),
                    title: "Medication",
                    petProfileId: widget.petProfileDetails.profileId,
                    refreshHealthIssues: () {
                      _refreshMedicalInformation();
                    },
                    newName: "New Medication",
                    newType: "medication",
                    medicalInformationId: snapshot.data!.medicalInformationId,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              "error loading version",
              style: Theme.of(context).textTheme.labelSmall,
            );
          } else {
            //Loading
            return Text(
              "Loading Version",
              style: Theme.of(context).textTheme.labelSmall,
            );
          }
        },
      ),
    );
  }
}
