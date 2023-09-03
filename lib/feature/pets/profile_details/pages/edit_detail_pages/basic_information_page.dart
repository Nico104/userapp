import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_color/hex_color.dart';

import '../../c_component_padding.dart';
import '../../c_description.dart';
import '../../c_important_information.dart';
import '../../c_one_line_simple_input.dart';
import '../../c_pet_gender.dart';
import '../../models/m_pet_profile.dart';
import '../../u_profile_details.dart';
import '../../widgets/two_options_button.dart';

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

  @override
  void initState() {
    super.initState();
    _gender = widget.petProfileDetails.petGender;
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
          PaddingComponent(
            child: TwoOptionButton(
              title: "Friendly to Strangers",
              activeOption: ActiveOption.option1,
              optionLabel1: "Yes",
              optionLabel2: "No",
              onTap: (p0) {},
            ),
          ),
          PaddingComponent(
            child: TwoOptionButton(
              title: "Good with Kids",
              activeOption: ActiveOption.option1,
              optionLabel1: "Yes",
              optionLabel2: "No",
              onTap: (p0) {},
            ),
          ),
          PaddingComponent(
            child: TwoOptionButton(
              title: "Good with Dogs",
              activeOption: ActiveOption.option1,
              optionLabel1: "Yes",
              optionLabel2: "No",
              onTap: (p0) {},
            ),
          ),
          PaddingComponent(
            child: TwoOptionButton(
              title: "Good with Cats",
              activeOption: ActiveOption.option1,
              optionLabel1: "Yes",
              optionLabel2: "No",
              onTap: (p0) {},
            ),
          ),
          PaddingComponent(
            child: TwoOptionButton(
              title: "Good with Cars",
              activeOption: ActiveOption.option1,
              optionLabel1: "Yes",
              optionLabel2: "No",
              onTap: (p0) {},
            ),
          ),
        ],
      ),
    );
  }
}
