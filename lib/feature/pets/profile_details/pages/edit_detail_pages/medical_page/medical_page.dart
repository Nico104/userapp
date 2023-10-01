import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
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
                ? CustomLoadingIndicatior()
                : Column(
                    children: [
                      SizedBox(height: 42),
                      PaddingComponent(
                        // child: TwoOptionButton(
                        //   activeColorOption1: HexColor("8be28b"),
                        //   inactiveColorOption1: Colors.black.withOpacity(0.1),
                        //   activeColorOption2: HexColor("ff6961"),
                        //   inactiveColorOption2: Colors.black.withOpacity(0.1),
                        //   title: "Is Tabo Sterilized?",
                        //   activeOption: _medicalInformation!.sterilized == true
                        //       ? ActiveOption.option1
                        //       : _medicalInformation?.sterilized == false
                        //           ? ActiveOption.option2
                        //           : ActiveOption.inactive,
                        //   optionLabel1: "Yes",
                        //   optionLabel2: "No",
                        //   onTap: (val) {
                        //     if (val == 0) {
                        //       _medicalInformation?.sterilized = null;
                        //     } else if (val == 1) {
                        //       _medicalInformation?.sterilized = true;
                        //     } else if (val == 2) {
                        //       _medicalInformation?.sterilized = false;
                        //     }

                        //     updateMedicalInformation(_medicalInformation!);
                        //     setState(() {});
                        //   },
                        // ),
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
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 0.5,
                          height: 0,
                        ),
                        padding: EdgeInsets.all(16 + 8),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: healthIssues.length,
                        itemBuilder: (context, index) {
                          return PaddingComponent(
                            child: HealthIssueList(
                              list: healthIssues.entries.elementAt(index).value,
                              title: healthIssues.entries
                                  .elementAt(index)
                                  .key
                                  .capitalize(),
                              petProfileId: widget.petProfileDetails.profileId,
                              refreshHealthIssues: () {
                                _refreshMedicalInformation();
                              },
                              newName: "New Allergy",
                              newType: "allergies",
                              medicalInformationId:
                                  _medicalInformation!.medicalInformationId,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 90.h,
                      )
                    ],
                  ),
          ),
          _medicalInformation == null
              ? const SizedBox.shrink()
              : ShyButton(
                  showUploadButton: _showShyButton,
                  label: "medical_NewHealthIssueLabel".tr(),
                  onTap: () {
                    showCustomNicoLoadingModalBottomSheet(
                      context: context,
                      future: createHealthIssue(
                        healthIssueName: "defaultHealthIssuesName".tr(),
                        healthIssueType: "defaultHealthIssueType".tr(),
                        medicalId: _medicalInformation!.medicalInformationId,
                      ),
                      callback: (value) {
                        _refreshMedicalInformation();
                        Navigator.of(context)
                            .push(
                          PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            pageBuilder: (BuildContext context, _, __) {
                              return HealthIssueUpdateBox(
                                healthIssue: value,
                                petProfileId:
                                    widget.petProfileDetails.profileId,
                              );
                            },
                          ),
                        )
                            .then((value) {
                          _refreshMedicalInformation();
                        });
                      },
                    );
                  },
                  icon: Icon(
                    Icons.medical_information_rounded,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
