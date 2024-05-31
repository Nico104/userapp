import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/scans/scans_list_item.dart';
import 'package:userapp/feature/settings/setting_screens/notifcation_settings/notification_settings_item.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

class VisibilityMenu extends StatefulWidget {
  const VisibilityMenu({
    Key? key,
    required this.petProfileDetails,
  }) : super(key: key);

  final PetProfileDetails petProfileDetails;

  @override
  State<VisibilityMenu> createState() => _VisibilityMenuState();
}

class _VisibilityMenuState extends State<VisibilityMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomNicoScrollView(
        title: Text("Visiblity Menu"),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 42),
              NotificationSettingsItem(
                label: "Hide Contacts",
                description:
                    "Hides Contacts for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_contacts,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_contacts = value;
                  });
                  print(widget.petProfileDetails.hide_contacts);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
              const SizedBox(height: 32),
              NotificationSettingsItem(
                label: "Hide Informations",
                description:
                    "Hides Informations for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_information,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_information = value;
                  });
                  print(widget.petProfileDetails.hide_information);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
              const SizedBox(height: 32),
              NotificationSettingsItem(
                label: "Hide Medical Informations",
                description:
                    "Hides Medical Informations for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_medical,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_medical = value;
                  });
                  print(widget.petProfileDetails.hide_medical);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
              const SizedBox(height: 32),
              NotificationSettingsItem(
                label: "Hide Pictures",
                description:
                    "Hides Pictures for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_pictures,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_pictures = value;
                  });
                  print(widget.petProfileDetails.hide_pictures);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
              const SizedBox(height: 32),
              NotificationSettingsItem(
                label: "Hide Description",
                description:
                    "Hides Description for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_description,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_description = value;
                  });
                  print(widget.petProfileDetails.hide_description);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
              const SizedBox(height: 32),
              NotificationSettingsItem(
                label: "Hide Documents",
                description:
                    "Hides Documents for people getting on ${widget.petProfileDetails.petName}'s profile",
                value: widget.petProfileDetails.hide_documents,
                setValue: (value) {
                  setState(() {
                    widget.petProfileDetails.hide_documents = value;
                  });
                  print(widget.petProfileDetails.hide_documents);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ],
          ),
        ),
        onScroll: () {},
      ),
    );
  }
}
