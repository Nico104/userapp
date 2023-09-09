import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/feature/pets/profile_details/models/m_behaviour_information.dart';
import 'package:userapp/general/utils_color/hex_color.dart';

import '../../../c_component_padding.dart';
import '../../../c_description.dart';
import '../../../c_important_information.dart';
import '../../../c_one_line_simple_input.dart';
import '../../../c_pet_gender.dart';
import '../../../models/m_pet_profile.dart';
import '../../../u_profile_details.dart';
import '../../../widgets/two_options_button.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({
    super.key,
    required this.petProfileDetails,
    required this.setGender,
  });

  @override
  State<BasicInformationPage> createState() => _BasicInformationPageState();

  final PetProfileDetails petProfileDetails;
  final void Function(Gender) setGender;
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
      appBar: AppBar(
        title: Text("Basic Information"),
      ),
      body: ListView(
        children: [
          PaddingComponent(
            child: OnelineSimpleInput(
              flex: 7,
              value: widget.petProfileDetails.petName,
              emptyValuePlaceholder: "George the Second",
              title: "Name",
              saveValue: (val) async {
                widget.petProfileDetails.petChipId = val;
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
          PaddingComponent(
            child: OnelineSimpleInput(
              flex: 7,
              value: widget.petProfileDetails.petChipId ?? "",
              emptyValuePlaceholder: "977200000000000",
              title: "profileDetailsComponentTitleChipNumber".tr(),
              saveValue: (val) async {
                widget.petProfileDetails.petChipId = val;
                updatePetProfileCore(widget.petProfileDetails);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Beheaviour",
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          FutureBuilder(
            future: _behaviourInformationFuture,
            builder: (BuildContext context,
                AsyncSnapshot<BehaviourInformation> snapshot) {
              if (snapshot.hasData) {
                BehaviourInformation behaviourInformation = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PaddingComponent(
                      child: TwoOptionButton(
                        title: "Friendly to Strangers",
                        activeOption: behaviourInformation.goodWithStrangers ==
                                true
                            ? ActiveOption.option1
                            : behaviourInformation.goodWithStrangers == false
                                ? ActiveOption.option2
                                : ActiveOption.inactive,
                        optionLabel1: "Yes",
                        optionLabel2: "No",
                        onTap: (val) {
                          if (val == 0) {
                            behaviourInformation.goodWithStrangers = null;
                          } else if (val == 1) {
                            behaviourInformation.goodWithStrangers = true;
                          } else if (val == 2) {
                            behaviourInformation.goodWithStrangers = false;
                          }
                          updateBehaviourInformation(behaviourInformation);
                          setState(() {});
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: TwoOptionButton(
                        title: "Good with Kids",
                        activeOption: behaviourInformation.goodWithKids == true
                            ? ActiveOption.option1
                            : behaviourInformation.goodWithKids == false
                                ? ActiveOption.option2
                                : ActiveOption.inactive,
                        optionLabel1: "Yes",
                        optionLabel2: "No",
                        onTap: (val) {
                          if (val == 0) {
                            behaviourInformation.goodWithKids = null;
                          } else if (val == 1) {
                            behaviourInformation.goodWithKids = true;
                          } else if (val == 2) {
                            behaviourInformation.goodWithKids = false;
                          }
                          updateBehaviourInformation(behaviourInformation);
                          setState(() {});
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: TwoOptionButton(
                        title: "Good with Dogs",
                        activeOption: behaviourInformation.goodWithDogs == true
                            ? ActiveOption.option1
                            : behaviourInformation.goodWithDogs == false
                                ? ActiveOption.option2
                                : ActiveOption.inactive,
                        optionLabel1: "Yes",
                        optionLabel2: "No",
                        onTap: (val) {
                          if (val == 0) {
                            behaviourInformation.goodWithDogs = null;
                          } else if (val == 1) {
                            behaviourInformation.goodWithDogs = true;
                          } else if (val == 2) {
                            behaviourInformation.goodWithDogs = false;
                          }
                          updateBehaviourInformation(behaviourInformation);
                          setState(() {});
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: TwoOptionButton(
                        title: "Good with Cats",
                        activeOption: behaviourInformation.goodWithCats == true
                            ? ActiveOption.option1
                            : behaviourInformation.goodWithCats == false
                                ? ActiveOption.option2
                                : ActiveOption.inactive,
                        optionLabel1: "Yes",
                        optionLabel2: "No",
                        onTap: (val) {
                          if (val == 0) {
                            behaviourInformation.goodWithCats = null;
                          } else if (val == 1) {
                            behaviourInformation.goodWithCats = true;
                          } else if (val == 2) {
                            behaviourInformation.goodWithCats = false;
                          }
                          updateBehaviourInformation(behaviourInformation);
                          setState(() {});
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: TwoOptionButton(
                        title: "Good with Cars",
                        activeOption: behaviourInformation.goodWithCars == true
                            ? ActiveOption.option1
                            : behaviourInformation.goodWithCars == false
                                ? ActiveOption.option2
                                : ActiveOption.inactive,
                        optionLabel1: "Yes",
                        optionLabel2: "No",
                        onTap: (val) {
                          if (val == 0) {
                            behaviourInformation.goodWithCars = null;
                          } else if (val == 1) {
                            behaviourInformation.goodWithCars = true;
                          } else if (val == 2) {
                            behaviourInformation.goodWithCars = false;
                          }
                          updateBehaviourInformation(behaviourInformation);
                          setState(() {});
                        },
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
        ],
      ),
    );
  }
}
