import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/c_component_title.dart';
import 'package:userapp/feature/pets/profile_details/models/m_behaviour_information.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../../../../general/widgets/future_error_widget.dart';
import '../../../c_component_padding.dart';
import '../../../c_one_line_simple_input.dart';
import '../../../c_pet_gender.dart';
import '../../../models/m_pet_profile.dart';
import '../../../u_profile_details.dart';
import '../../../widgets/multi_options_button.dart';
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
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
                height: 0,
              ),
              padding: EdgeInsets.all(16 + 8),
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
                        child: MultiOptionButton(
                          title:
                              "basicInformationPage_friendlyToStrangers".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "Good with Kids",
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithDogs".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithCats".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithCars".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
                      PaddingComponent(
                        child: MultiOptionButton(
                          title: "basicInformationPage_goodWithLoudNoises".tr(),
                          initialActiveIndex: 0,
                          options: [
                            Option("basicInformationPage_yes".tr()),
                            Option("basicInformationPage_sometimes".tr()),
                            Option("basicInformationPage_no".tr()),
                          ],
                        ),
                      ),
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
            SizedBox(height: 40.h),
          ],
        ),
        onScroll: () {},
      ),
    );
  }
}
