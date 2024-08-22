import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/pets/profile_details/visibility/visibility_menu_choose_dialog.dart';
import 'package:userapp/feature/pets/profile_details/visibility/visibility_tab.dart';
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
  //0 - Sshare 1 - Share
  int _index = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomNicoScrollView(
        title: Text("visibilityMenuTitle".tr()),
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 42),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "visibility_menu_description".tr(),
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
            VisibilityTab(
              index: _index,
              onTap: (p0) {
                // setState(() {
                //   pageController.animateToPage(p0,
                //       duration: Durations.short1,
                //       curve: Curves.fastEaseInToSlowEaseOut);
                //   _index = p0;
                // });
                pageController.animateToPage(
                  p0,
                  duration: Durations.long1,
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              },
            ),
            SizedBox(
              height: 1000,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _index = value;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 42),
                          Text(
                            "visibility_menu_share_description_1".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "visibility_menu_share_description_2".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 42),
                          NotificationSettingsItem(
                            label: "VisibilityHideContactsTitle".tr(),
                            description: "VisibilityHideContactsLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
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
                            label: "VisibilityHideInformationTitle".tr(),
                            description: "VisibilityHideInformationLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value: widget.petProfileDetails.hide_information,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.hide_information =
                                    value;
                              });
                              print(widget.petProfileDetails.hide_information);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideMedicalsTitle".tr(),
                            description: "VisibilityHideMedicalsLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
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
                            label: "VisibilityHidePicturesTitle".tr(),
                            description: "VisibilityHidePicturesLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
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
                            label: "VisibilityHideDescriptionTitle".tr(),
                            description: "VisibilityHideDescriptionLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value: widget.petProfileDetails.hide_description,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.hide_description =
                                    value;
                              });
                              print(widget.petProfileDetails.hide_description);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideDocumentsTitle".tr(),
                            description: "VisibilityHideDocumentsLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 42),
                          Text(
                            "visibility_menu_scan_description_1".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "visibility_menu_scan_description_2".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 42),
                          InkWell(
                            onTap: () => showVisibilityOption(context),
                            child: IgnorePointer(
                              child: NotificationSettingsItem(
                                label: "VisibilityHideContactsTitle".tr(),
                                description: "VisibilityHideContactsLabel"
                                    .tr(namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                                value:
                                    widget.petProfileDetails.scan_hide_contacts,
                                setValue: (value) {
                                  setState(() {
                                    widget.petProfileDetails
                                        .scan_hide_contacts = value;
                                  });
                                  print(widget
                                      .petProfileDetails.scan_hide_contacts);
                                  updatePetProfileCore(
                                      widget.petProfileDetails);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideInformationTitle".tr(),
                            description: "VisibilityHideInformationLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value:
                                widget.petProfileDetails.scan_hide_information,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.scan_hide_information =
                                    value;
                              });
                              print(widget
                                  .petProfileDetails.scan_hide_information);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideMedicalsTitle".tr(),
                            description: "VisibilityHideMedicalsLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value: widget.petProfileDetails.scan_hide_medical,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.scan_hide_medical =
                                    value;
                              });
                              print(widget.petProfileDetails.scan_hide_medical);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHidePicturesTitle".tr(),
                            description: "VisibilityHidePicturesLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value: widget.petProfileDetails.scan_hide_pictures,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.scan_hide_pictures =
                                    value;
                              });
                              print(
                                  widget.petProfileDetails.scan_hide_pictures);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideDescriptionTitle".tr(),
                            description: "VisibilityHideDescriptionLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value:
                                widget.petProfileDetails.scan_hide_description,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.scan_hide_description =
                                    value;
                              });
                              print(widget
                                  .petProfileDetails.scan_hide_description);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                          const SizedBox(height: 32),
                          NotificationSettingsItem(
                            label: "VisibilityHideDocumentsTitle".tr(),
                            description: "VisibilityHideDocumentsLabel".tr(
                                namedArgs: {
                                  'Karamba': widget.petProfileDetails.petName
                                }),
                            value: widget.petProfileDetails.scan_hide_documents,
                            setValue: (value) {
                              setState(() {
                                widget.petProfileDetails.scan_hide_documents =
                                    value;
                              });
                              print(
                                  widget.petProfileDetails.scan_hide_documents);
                              updatePetProfileCore(widget.petProfileDetails);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onScroll: () {},
      ),
    );
  }
}
