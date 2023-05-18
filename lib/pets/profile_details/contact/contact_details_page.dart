import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/phone_numbers/c_phone_number.dart';
import '../../../styles/custom_icons_icons.dart';
import '../../../theme/custom_text_styles.dart';
import '../../../utils/widgets/more_button.dart';
import '../c_component_padding.dart';
import '../c_one_line_simple_input.dart';
import '../c_pet_name.dart';
import '../c_social_media.dart';
import '../d_confirm_delete.dart';
import '../models/m_contact.dart';
import '../pictures/upload_picture_dialog.dart';
import 'contact_description/contact_description.dart';
import 'contact_picture/contact_picture_widget.dart';
import 'u_contact.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late Contact contact;

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  void reloadContact() async {
    contact = await getPetContact(widget.contact.contactId);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _getMoreButton() {
    return MoreButton(
      moreOptions: [
        ListTile(
          leading: Icon(CustomIcons.delete),
          title: Text("Delete Contact"),
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
                  deleteContact(contact).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('appBarTitleProfileDetails'.tr()),
        title: Text("${contact.contactName}'s Contact Details"),
        scrolledUnderElevation: 8,
      ),
      body: ScrollConfiguration(
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
                        contactPictureLink: contact.contactPictureLink,
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
                            contact.contactId,
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
                          if (contact.contactPictureLink != null) {
                            deleteContactPicture(
                              contact.contactId,
                              contact.contactPictureLink!,
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
                            contact.contactName,
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
                                      initialValue: contact.contactName,
                                      label: "Contact Name",
                                      confirmLabel: "Save ahead",
                                    ),
                                  ).then((value) {
                                    if (value != null) {
                                      contact.contactName = value;
                                      updateContact(contact);
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
                          ContactDescriptionComponent(
                            contact: contact,
                          ),
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
                      value: contact.contactAddress ?? "",
                      emptyValuePlaceholder: "Mainstreet 20A, Vienna, Austria",
                      title: "profileDetailsComponentTitleHomeAddress".tr(),
                      saveValue: (val) async {
                        contact.contactAddress = val;
                        updateContact(contact);
                      },
                    ),
                  ),
                  PaddingComponent(
                    child: OnelineSimpleInput(
                      flex: 8,
                      value: contact.contactEmail ?? "",
                      emptyValuePlaceholder: "Email",
                      // title: "profileDetailsComponentTitleOwnerEmail".tr(),
                      title: "Email",
                      saveValue: (val) async {
                        contact.contactEmail = val;
                        updateContact(contact);
                      },
                    ),
                  ),
                  PaddingComponent(
                    child: PetPhoneNumbersComponent(
                      phoneNumbers: contact.contactTelephoneNumbers,
                      contactId: contact.contactId,
                    ),
                  ),
                  PaddingComponent(
                    child: SocialMediaComponent(
                      title: "profileDetailsComponentTitleSocialMedia".tr(),
                      facebook: contact.contactFacebook ?? "",
                      saveFacebook: (val) async {
                        contact.contactFacebook = val;
                        updateContact(contact);
                      },
                      instagram: contact.contactInstagram ?? "",
                      saveInstagram: (val) async {
                        contact.contactInstagram = val;
                        updateContact(contact);
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
    );
  }
}
