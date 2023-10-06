import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/feature/pets/profile_details/phone_numbers/c_phone_number.dart';
import 'package:userapp/general/utils_general.dart';
import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../general/widgets/custom_nico_modal.dart';
import '../../../../general/widgets/more_button.dart';
import '../../u_pets.dart';
import '../c_component_padding.dart';
import '../c_one_line_simple_input.dart';
import '../c_pet_name.dart';
import '../c_social_media.dart';
import '../d_confirm_delete.dart';
import '../models/m_contact.dart';
import '../pictures/upload_picture_dialog.dart';
import 'contact_description/contact_description.dart';
import 'contact_picture/contact_picture_widget.dart';
import 'languages_spoken/languages_spoken_widget.dart';
import 'u_contact.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({
    super.key,
    required this.contact,
    this.petProfileDetails,
  });

  final Contact contact;
  final PetProfileDetails? petProfileDetails;

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late Contact _contact;
  List<PetProfileDetails> _connectedPetProfiles = List.empty();

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
    loadConnectedPets();
  }

  void reloadContact() async {
    _contact = await getContact(widget.contact.contactId);
    if (mounted) {
      setState(() {});
    }
  }

  void loadConnectedPets() async {
    _connectedPetProfiles = await getPetsFromContact(widget.contact.contactId);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _getMoreButton() {
    if (widget.petProfileDetails != null) {
      return MoreButton(
        moreOptions: [
          // ListTile(
          //   leading: const Icon(Icons.remove_circle_outline),
          //   title: Text(
          //       "Disconnect Contact from ${widget.petProfileDetails!.petName}"),
          //   onTap: () {
          //     Navigator.pop(context);
          //     showDialog(
          //       context: context,
          //       builder: (_) => const ConfirmDeleteDialog(
          //         label: "Contact",
          //         remove: true,
          //       ),
          //     ).then((value) {
          //       if (value != null) {
          //         if (value == true) {
          //           // deleteContact(contact).then((value) {
          //           //   Navigator.pop(context);
          //           // });
          //           disconnectContactFromPet(
          //                   contactId: _contact.contactId,
          //                   petProfileId: widget.petProfileDetails!.profileId)
          //               .then((value) {
          //             Navigator.pop(context);
          //           });
          //         }
          //       }
          //     });
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.remove_circle_outline),
            title: Text("contact_ShareContact".tr()),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(CustomIcons.delete),
            title: Text("contactMenuDeleteContact".tr()),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => ConfirmDeleteDialog(
                  label: "contactMenuDeleteContactDialogLabel".tr(),
                ),
              ).then((value) {
                if (value != null) {
                  if (value == true) {
                    deleteContact(_contact).then((value) {
                      Navigator.pop(context);
                    });
                  }
                }
              });
            },
          ),
        ],
      );
    } else {
      return MoreButton(
        moreOptions: [
          for (PetProfileDetails petProfile in _connectedPetProfiles)
            ListTile(
              leading: const Icon(Icons.pets),
              title: Text("contactGoToPet"
                  .tr(namedArgs: {'value1': petProfile.petName})),
              onTap: () {
                Navigator.pop(context);
                navigatePerSlide(
                  context,
                  PetPage2(petProfileDetails: petProfile),
                  callback: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ListTile(
            leading: const Icon(CustomIcons.delete),
            title: Text("contactMenuDeleteContact".tr()),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => const ConfirmDeleteDialog(
                  label: "Contact",
                ),
              ).then((value) {
                if (value != null) {
                  if (value == true) {
                    deleteContact(_contact).then((value) {
                      Navigator.pop(context);
                    });
                  }
                }
              });
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarContactDetails'
            .tr(namedArgs: {'value1': _contact.contactName})),
        scrolledUnderElevation: 8,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 400,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        ContactPicture(
                          contactPictureLink: _contact.contactPictureLink,
                          addContactPicture: (value) async {
                            //Loading Dialog Thingy
                            BuildContext? dialogContext;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                dialogContext = context;
                                return const UploadPictureDialog();
                              },
                            );
                            await uploadContactPicture(
                              _contact.contactId,
                              value,
                              () async {
                                // widget.reloadFuture.call();
                                //hekps against 403 from server
                                await Future.delayed(
                                        const Duration(milliseconds: 2000))
                                    .then((value) {
                                  reloadContact();
                                });
                                //Close Loading Dialog Thingy
                                Navigator.pop(dialogContext!);
                              },
                            );
                          },
                          onDelete: () {
                            if (_contact.contactPictureLink != null) {
                              deleteContactPicture(
                                _contact.contactId,
                                _contact.contactPictureLink!,
                              ).then((value) {
                                // widget.reloadFuture.call();
                                // refresh();
                                reloadContact();
                              });
                            }
                          },
                        ),
                        // const SizedBox(height: 36),
                        const Spacer(
                          flex: 3,
                        ),
                        //Name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(
                              _contact.contactName,
                              style: getCustomTextStyles(context)
                                  .profileDetailsPetName,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => EnterNameDialog(
                                        initialValue: _contact.contactName,
                                        title:
                                            "contactDetailsChangeContactNameTitle"
                                                .tr(),
                                        hint:
                                            "contactDetailsChangeContactNameHint"
                                                .tr(),
                                        confirmLabel:
                                            "contactDetailsSaveContactNameLabel"
                                                .tr(),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        _contact.contactName = value;
                                        updateContact(_contact);
                                        setState(() {});
                                      }
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, bottom: 14, right: 14),
                                    child: Icon(
                                      CustomIcons.edit_square,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 22),
                        const Spacer(
                          flex: 2,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            // ContactDescriptionComponent(
                            //   contact: _contact,
                            // ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: _getMoreButton(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    PaddingComponent(
                      child: OnelineSimpleInput(
                        flex: 8,
                        value: _contact.contactAddress ?? "",
                        emptyValuePlaceholder:
                            "contactDetailsPage_mainstreetVienna".tr(),
                        title: "profileDetailsComponentTitleHomeAddress".tr(),
                        saveValue: (val) async {
                          _contact.contactAddress = val;
                          updateContact(_contact);
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: OnelineSimpleInput(
                        flex: 8,
                        value: _contact.contactEmail ?? "",
                        emptyValuePlaceholder: "contactDetailsPage_email".tr(),
                        // title: "profileDetailsComponentTitleOwnerEmail".tr(),
                        title: "contactDetailsPage_email".tr(),
                        saveValue: (val) async {
                          _contact.contactEmail = val;
                          updateContact(_contact);
                        },
                      ),
                    ),
                    PaddingComponent(
                      child: LanguagesSpoken(
                        contact: _contact,
                        reloadContact: reloadContact,
                      ),
                    ),
                    PaddingComponent(
                      child: PetPhoneNumbersComponent(
                        phoneNumbers: _contact.contactTelephoneNumbers,
                        contactId: _contact.contactId,
                      ),
                    ),
                    PaddingComponent(
                      child: SocialMediaComponent(
                        title: "profileDetailsComponentTitleSocialMedia".tr(),
                        facebook: _contact.contactFacebook ?? "",
                        saveFacebook: (val) async {
                          _contact.contactFacebook = val;
                          updateContact(_contact);
                        },
                        instagram: _contact.contactInstagram ?? "",
                        saveInstagram: (val) async {
                          _contact.contactInstagram = val;
                          updateContact(_contact);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
