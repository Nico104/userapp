import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:userapp/feature/pets/profile_details/c_multi_line_simple_input.dart';
import 'package:userapp/feature/pets/profile_details/c_one_line_simple_input.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/general/widgets/auto_save_info.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../../../../general/widgets/custom_nico_modal.dart';
import '../../../../../../general/widgets/loading_indicator.dart';
import '../../../c_component_padding.dart';
import '../../../models/m_pet_profile.dart';
import '../../../models/medical/m_health_issue.dart';
import '../../../models/medical/m_medical_information.dart';
import '../../../widgets/multi_options_button.dart';
import '../../../../../../general/widgets/shy_button.dart';
import 'health_issues/health_issue_update_box.dart';
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
  // late Future<MedicalInformation> future;
  MedicalInformation? _medicalInformation;
  Map<String, List<HealthIssue>> healthIssues = {};
  bool _showShyButton = true;

  @override
  void initState() {
    super.initState();
    // future = getMedicalInformation(widget.petProfileDetails.profileId);
    _refreshMedicalInformation();
  }

  Future<void> _refreshMedicalInformation() async {
    MedicalInformation medicalInformation =
        await getMedicalInformation(widget.petProfileDetails.profileId);
    healthIssues = groupBy(
      medicalInformation.healthIssues,
      (p0) => p0.healthIssueType,
    );
    _medicalInformation = medicalInformation;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          CustomNicoScrollView(
            onScroll: () => handleShyButtonShown(
              setShowShyButton: (p0) {
                setState(() {
                  _showShyButton = p0;
                });
              },
            ),
            title: Text("medical_Title".tr()),
            body: _medicalInformation == null
                ? const CustomLoadingIndicatior()
                : Column(
                    children: [
                      const SizedBox(height: 42),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "medical_Neutered".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16 + 8),
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 0.5,
                          height: 0,
                        ),
                      ),
                      PaddingComponent(
                        child: OnelineSimpleInput(
                          flex: 7,
                          value: _medicalInformation?.breed ?? "",
                          emptyValuePlaceholder:
                              "medicalInformation_breed".tr(),
                          title: "medicalInformation_breed".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.breed = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: OnelineSimpleInput(
                          flex: 7,
                          value: _medicalInformation?.age ?? "",
                          emptyValuePlaceholder: "medicalInformation_age".tr(),
                          title: "medicalInformation_age".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.age = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16 + 8),
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 0.5,
                          height: 0,
                        ),
                      ),
                      PaddingComponent(
                        child: MultiSimpleInput(
                          // flexSpacer: 0,
                          value: _medicalInformation?.vaccinations ?? "",
                          emptyValuePlaceholder:
                              "medicalPage_enterVaccinations".tr(),
                          title: "medicalPage_enterVaccinations".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.vaccinations = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiSimpleInput(
                          // flexSpacer: 0,
                          value: _medicalInformation?.allergies ?? "",
                          emptyValuePlaceholder:
                              "medicalPage_enterAllergies".tr(),
                          title: "medicalPage_enterAllergies".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.allergies = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiSimpleInput(
                          // flexSpacer: 0,
                          value: _medicalInformation?.medications ?? "",
                          emptyValuePlaceholder:
                              "medicalPage_enterMedications".tr(),
                          title: "medicalPage_enterMedications".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.medications = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiSimpleInput(
                          // flexSpacer: 0,
                          value: _medicalInformation?.chronicConditions ?? "",
                          emptyValuePlaceholder:
                              "medicalPage_enterChronicConditions".tr(),
                          title: "medicalPage_enterChronicConditions".tr(),
                          saveValue: (val) async {
                            if (val.isNotEmpty) {
                              _medicalInformation?.chronicConditions = val;
                              updateMedicalInformation(_medicalInformation!);
                              _refreshMedicalInformation();
                            }
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: CustomTextFormField(
                      //     hintText: "medicalPage_enterVacciantions".tr(),
                      //     maxLines: null,
                      //     keyboardType: TextInputType.multiline,
                      //     onChanged: (val) {},
                      //     showSuffix: false,
                      //   ),
                      // ),
                      // ListView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: healthIssues.length,
                      //   itemBuilder: (context, index) {
                      //     return PaddingComponent(
                      //       child: HealthIssueList(
                      //         list: healthIssues.entries.elementAt(index).value,
                      //         title: healthIssues.entries.elementAt(index).key,
                      //         petProfileId: widget.petProfileDetails.profileId,
                      //         refreshHealthIssues: () {
                      //           _refreshMedicalInformation();
                      //         },
                      //         newName: "New Allergy",
                      //         newType: "allergies",
                      //         medicalInformationId:
                      //             _medicalInformation!.medicalInformationId,
                      //       ),
                      //     );
                      //   },
                      // ),

                      const AutoSaveInfo(),
                    ],
                  ),
          ),
          // _medicalInformation == null
          //     ? const SizedBox.shrink()
          //     : ShyButton(
          //         showUploadButton: _showShyButton,
          //         label: "medical_NewHealthIssueLabel".tr(),
          //         onTap: () {
          //           showCustomNicoLoadingModalBottomSheet(
          //             context: context,
          //             future: createHealthIssue(
          //               healthIssueName: "defaultHealthIssuesName".tr(),
          //               healthIssueType: "defaultHealthIssueType".tr(),
          //               medicalId: _medicalInformation!.medicalInformationId,
          //             ),
          //             callback: (value) {
          //               _refreshMedicalInformation();
          //               Navigator.of(context)
          //                   .push(
          //                 PageRouteBuilder(
          //                   opaque: false,
          //                   barrierDismissible: true,
          //                   pageBuilder: (BuildContext context, _, __) {
          //                     return HealthIssueUpdateBox(
          //                       healthIssue: value,
          //                       petProfileId:
          //                           widget.petProfileDetails.profileId,
          //                     );
          //                   },
          //                 ),
          //               )
          //                   .then((value) {
          //                 _refreshMedicalInformation();
          //               });
          //             },
          //           );
          //         },
          //         icon: const Icon(
          //           Icons.medical_information_rounded,
          //           color: Colors.white,
          //         ),
          //       ),
        ],
      ),
    );
  }
}
