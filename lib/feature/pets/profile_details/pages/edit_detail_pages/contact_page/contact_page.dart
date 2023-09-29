import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';

import '../../../../../../general/utils_general.dart';
import '../../../../../../general/widgets/custom_scroll_view.dart';
import '../../../c_pet_name.dart';
import '../../../contact/contact_details_page.dart';
import '../../../contact/contact_list_item.dart';
import '../../../contact/contacts_selection_ist_page.dart';
import '../../../models/m_contact.dart';
import '../../../models/m_pet_profile.dart';
import 'add_contact_header.dart';
import 'contact_visibility_switch.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    required this.petProfileDetails,
  });

  final PetProfileDetails petProfileDetails;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // final ScrollController _scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     _scrollController.addListener(() {
  //       _handleNavBarShown();
  //     });
  //   });
  // }

  // void _handleNavBarShown() {
  //   //hideBar
  //   widget.showBottomNavBar(false);
  //   EasyDebounce.debounce(
  //     'handleNavBarShown',
  //     const Duration(milliseconds: 350),
  //     () {
  //       //shwoNavbar
  //       widget.showBottomNavBar(true);
  //     },
  //   );
  // }

  Future<void> refreshContacts() async {
    List<Contact> contracts =
        await fetchPetContracts(widget.petProfileDetails.profileId);
    setState(() {
      widget.petProfileDetails.petContacts = contracts;
    });
  }

  void addNewContact() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (buildContext) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(buildContext).primaryColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.list),
                title: Text("contactPage_addExistingContact".tr()),
                onTap: () {
                  Navigator.pop(buildContext);
                  navigatePerSlide(
                    context,
                    SelectionContactsPage(
                      alreadyConnectedContacts:
                          widget.petProfileDetails.petContacts,
                      petProfileDetails: widget.petProfileDetails,
                    ),
                    callback: () => refreshContacts(),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text("contactPage_createNewContact".tr()),
                onTap: () {
                  Navigator.pop(buildContext);
                  showDialog(
                    context: context,
                    builder: (_) => EnterNameDialog(
                      title: "contactDetailsChangeContactNameTitle".tr(),
                      hint: "contactDetailsChangeContactNameHint".tr(),
                      confirmLabel: "Create",
                    ),
                  ).then((value) async {
                    if (value != null && value.isNotEmpty) {
                      Contact contact = await createNewContact(
                        contactName: value,
                      );
                      await connectContactToPet(
                        contactId: contact.contactId,
                        petProfileId: widget.petProfileDetails.profileId,
                      );
                      // refreshContacts();
                      if (context.mounted) {
                        navigatePerSlide(
                          context,
                          ContactDetailsPage(
                            contact: contact,
                            petProfileDetails: widget.petProfileDetails,
                          ),
                          callback: () => refreshContacts(),
                        );
                      }
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            title: Text("contactPage_Contact".tr()),
            expandedHeight: 190,
            background: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tabo's",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w200,
                      fontSize: 18 * 1.5,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "contactPage_Contact".tr(),
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                              color: Colors.transparent,
                              fontSize: 20 * 1.5,
                            ),
                  ),
                ],
              ),
            ),
            onScroll: () {},
            body: Column(
              children: [
                const SizedBox(height: 16),
                //New Contact
                AddContactHeader(
                  addNewContact: addNewContact,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'appBarPetContactList'.tr(namedArgs: {
                        'name': widget.petProfileDetails.petName
                      }),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // controller: _scrollController,
                  itemCount: widget.petProfileDetails.petContacts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: ContactListItem(
                        contact: widget.petProfileDetails.petContacts
                            .elementAt(index),
                        petProfileDetails: widget.petProfileDetails,
                        refreshContacts: () {
                          refreshContacts();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 75.h),
              ],
            ),
          ),
          ContactVisibilitySwitch(
            petProfileDetails: widget.petProfileDetails,
          ),
        ],
      ),
    );
  }
}
