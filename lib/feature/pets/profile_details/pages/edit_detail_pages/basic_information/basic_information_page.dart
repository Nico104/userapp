import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/c_multi_line_simple_input.dart';
import 'package:userapp/feature/pets/profile_details/models/m_behaviour_information.dart';
import 'package:userapp/general/widgets/auto_save_info.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../../../../general/widgets/future_error_widget.dart';
import '../../../c_component_padding.dart';
import '../../../c_one_line_simple_input.dart';
import '../../../c_pet_gender.dart';
import '../../../models/m_pet_profile.dart';
import '../../../u_profile_details.dart';
import '../../../widgets/multi_options_button.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({
    super.key,
    required this.petProfileDetails,
    required this.setGender,
    required this.reloadPetProfileDetails,
  });

  @override
  State<BasicInformationPage> createState() => _BasicInformationPageState();

  final PetProfileDetails petProfileDetails;
  final void Function(Gender) setGender;
  final void Function() reloadPetProfileDetails;
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  Gender? _gender;
  late Future<BehaviourInformation> _behaviourInformationFuture;

  @override
  void initState() {
    super.initState();
    _gender = widget.petProfileDetails.petGender;
    _behaviourInformationFuture =
        getBehaviourInformation(widget.petProfileDetails.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNicoScrollView(
        title: Text("basicInformationPage_basicinformation".tr()),
        body: Column(
          children: [
            const SizedBox(height: 16),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 7,
                value: widget.petProfileDetails.petName,
                emptyValuePlaceholder: "basicInformationPage_nameofthePet".tr(),
                title: "basicInformationPage_name".tr(),
                saveValue: (val) async {
                  if (val.isNotEmpty) {
                    widget.petProfileDetails.petName = val;
                    updatePetProfileCore(widget.petProfileDetails);
                  }
                },
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 7,
                value: widget.petProfileDetails.petChipId ?? "",
                emptyValuePlaceholder:
                    "basicInformationPage_petchipIDnumbers".tr(),
                title: "profileDetailsComponentTitleChipNumber".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.petChipId = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 7,
                value: widget.petProfileDetails.pet_licenceID ?? "",
                emptyValuePlaceholder:
                    "basicInformationPage_licensenumbers".tr(),
                title: "basicInformationPage_licensenumbers".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_licenceID = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 7,
                value: widget.petProfileDetails.petChipId ?? "",
                emptyValuePlaceholder: "basicInformationPage_tattooID".tr(),
                title: "basicInformationPage_tattooID".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_tattooID = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),

            PaddingComponent(
              child: PetGenderComponent(
                gender: _gender,
                setGender: (value) {
                  setState(() {
                    _gender = value;
                  });
                  widget.setGender(value);
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
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Behaviour",
            //       style: Theme.of(context).textTheme.titleMedium,
            //     ),
            //   ),
            // ),
            PaddingComponent(
              child: MultiSimpleInput(
                // flexSpacer: 0,
                value: widget.petProfileDetails.pet_favorite_toys ?? "",
                title: "basicInformationPage_favoriteToys".tr(),
                emptyValuePlaceholder:
                    "basicInformationPage_favoriteToysHint".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_favorite_toys = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: MultiSimpleInput(
                // flexSpacer: 0,
                value: widget.petProfileDetails.pet_favorite_activities ?? "",
                title: "basicInformationPage_favoriteActivities".tr(),
                emptyValuePlaceholder:
                    "basicInformationPage_favoriteActivitiesHint".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_favorite_activities = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: MultiSimpleInput(
                // flexSpacer: 0,
                value: widget.petProfileDetails.pet_behavioral_notes ?? "",
                title: "basicInformationPage_behavioralNotes".tr(),
                emptyValuePlaceholder:
                    "basicInformationPage_behavioralNotesHint".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_behavioral_notes = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: MultiSimpleInput(
                // flexSpacer: 0,
                value: widget.petProfileDetails.pet_special_needs ?? "",
                title: "basicInformationPage_specialNeeds".tr(),
                emptyValuePlaceholder:
                    "basicInformationPage_specialNeedsHint".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_special_needs = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: MultiSimpleInput(
                // flexSpacer: 0,
                value: widget.petProfileDetails.pet_diet_preferences ?? "",
                title: "basicInformationPage_dietPreferences".tr(),
                emptyValuePlaceholder:
                    "basicInformationPage_dietPreferencesHint".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.pet_diet_preferences = val;
                  updatePetProfileCore(widget.petProfileDetails);
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
            FutureBuilder(
              future: _behaviourInformationFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<BehaviourInformation> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  BehaviourInformation behaviourInformation = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PaddingComponent(
                        child: MultiOptionButton(
                          title:
                              "basicInformationPage_friendlyToStrangers".tr(),
                          initialActiveIndex:
                              getIndex(behaviourInformation.goodWithStrangers),
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            // Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                          onTap: (p0) {
                            behaviourInformation.goodWithStrangers =
                                getBool(p0);
                            updateBehaviourInformation(behaviourInformation);
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "Good with Kids",
                          initialActiveIndex:
                              getIndex(behaviourInformation.goodWithKids),
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                          onTap: (p0) {
                            behaviourInformation.goodWithKids = getBool(p0);
                            updateBehaviourInformation(behaviourInformation);
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithDogs".tr(),
                          initialActiveIndex:
                              getIndex(behaviourInformation.goodWithDogs),
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                          onTap: (p0) {
                            behaviourInformation.goodWithDogs = getBool(p0);
                            updateBehaviourInformation(behaviourInformation);
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithCats".tr(),
                          initialActiveIndex:
                              getIndex(behaviourInformation.goodWithCats),
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                          onTap: (p0) {
                            behaviourInformation.goodWithCats = getBool(p0);
                            updateBehaviourInformation(behaviourInformation);
                          },
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithCars".tr(),
                          initialActiveIndex:
                              getIndex(behaviourInformation.goodWithCars),
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                          onTap: (p0) {
                            behaviourInformation.goodWithCars = getBool(p0);
                            updateBehaviourInformation(behaviourInformation);
                          },
                        ),
                      ),
                      // PaddingComponent(
                      //   child: MultiOptionButton(
                      //     title: "basicInformationPage_goodWithLoudNoises".tr(),
                      //     initialActiveIndex:
                      //         getIndex(behaviourInformation.goodWith),
                      //     options: [
                      //       Option("basicInformationPage_yes".tr()),
                      //       Option("basicInformationPage_no".tr()),
                      //     ],
                      //     onTap: (p0) {
                      //       behaviourInformation.goodWithStrangers =
                      //           getBool(p0);
                      //       updateBehaviourInformation(behaviourInformation);
                      //     },
                      //   ),
                      // ),
                      const AutoSaveInfo(),
                      const SizedBox(height: 12),
                    ],
                  );
                } else if (snapshot.hasError) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FutureErrorWidget(),
                            ),
                          ).then((value) => setState(
                                () {},
                              )));
                  return const SizedBox.shrink();
                } else {
                  //Loading
                  return Text(
                    "basicInformationPage_LoadingVersion".tr(),
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                }
              },
            ),
          ],
        ),
        onScroll: () {},
      ),
    );
  }
}

int? getIndex(bool? val, {int indexYes = 0, int indexNo = 1}) {
  if (val == null) {
    return null;
  } else if (val) {
    return indexYes;
  } else {
    return indexNo;
  }
}

bool? getBool(int? index, {int indexYes = 0, int indexNo = 1}) {
  if (index == null) {
    return null;
  } else if (index == 0) {
    return true;
  } else {
    return false;
  }
}
