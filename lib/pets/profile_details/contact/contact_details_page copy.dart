import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/phone_numbers/c_phone_number.dart';
import '../../../styles/custom_icons_icons.dart';
import '../../../theme/custom_text_styles.dart';
import '../c_component_padding.dart';
import '../c_one_line_simple_input.dart';
import '../c_social_media.dart';
import '../models/m_contact.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('appBarTitleProfileDetails'.tr()),
        title: Text("${widget.contact.contactName}'s Contact Details"),
        scrolledUnderElevation: 8,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            key: const ValueKey("Contact"),
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36),
              Material(
                borderRadius: BorderRadius.circular(128),
                elevation: 2,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(128),
                    // border: Border.all(color: Colors.grey, width: 1.5),
                    image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/512"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              //Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    widget.contact.contactName,
                    style: getCustomTextStyles(context).profileDetailsPetName,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        // onTap: () => askForPetName(context, widget.setPetName,
                        //     widget.getProfileDetails().petName),
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 14, bottom: 14, right: 14),
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
              const SizedBox(height: 22),
              Container(
                // width: 70,
                // height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Owner",
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              PaddingComponent(
                child: OnelineSimpleInput(
                  flex: 6,
                  value: widget.contact.contactName,
                  emptyValuePlaceholder: "Schlongus Longus",
                  title: "profileDetailsComponentTitleOwnersName".tr(),
                  saveValue: (val) async {
                    widget.contact.contactName = val;
                    print(widget.contact.contactName);
                    updateContact(widget.contact);
                  },
                ),
              ),
              PaddingComponent(
                child: OnelineSimpleInput(
                  flex: 8,
                  value: widget.contact.contactAddress ?? "",
                  emptyValuePlaceholder: "Mainstreet 20A, Vienna, Austria",
                  title: "profileDetailsComponentTitleHomeAddress".tr(),
                  saveValue: (val) async {
                    widget.contact.contactAddress = val;
                    updateContact(widget.contact);
                  },
                ),
              ),
              PaddingComponent(
                child: OnelineSimpleInput(
                  flex: 8,
                  value: widget.contact.contactEmail ?? "",
                  emptyValuePlaceholder: "Email",
                  // title: "profileDetailsComponentTitleOwnerEmail".tr(),
                  title: "Email",
                  saveValue: (val) async {
                    widget.contact.contactEmail = val;
                    updateContact(widget.contact);
                  },
                ),
              ),
              PaddingComponent(
                child: PetPhoneNumbersComponent(
                  phoneNumbers: widget.contact.contactTelephoneNumbers,
                  contactId: widget.contact.contactId,
                ),
              ),
              PaddingComponent(
                child: SocialMediaComponent(
                  title: "profileDetailsComponentTitleSocialMedia".tr(),
                  facebook: widget.contact.contactFacebook ?? "",
                  saveFacebook: (val) async {
                    widget.contact.contactFacebook = val;
                    updateContact(widget.contact);
                  },
                  instagram: widget.contact.contactInstagram ?? "",
                  saveInstagram: (val) async {
                    widget.contact.contactInstagram = val;
                    updateContact(widget.contact);
                  },
                ),
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
