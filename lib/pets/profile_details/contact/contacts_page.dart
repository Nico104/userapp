import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/contact/u_contact.dart';
import '../c_pet_name.dart';
import '../models/m_contact.dart';
import '../models/m_pet_profile.dart';
import 'contact_details_page.dart';
import 'contact_list_item.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    required this.petProfileDetails,
    required this.showBottomNavBar,
  });

  final PetProfileDetails petProfileDetails;
  final void Function(bool) showBottomNavBar;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        _handleNavBarShown();
      });
    });
  }

  void _handleNavBarShown() {
    //hideBar
    widget.showBottomNavBar(false);
    EasyDebounce.debounce(
      'handleNavBarShown',
      const Duration(milliseconds: 350),
      () {
        //shwoNavbar
        widget.showBottomNavBar(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('appBarTitleProfileDetails'.tr()),
        title: Text("${widget.petProfileDetails.petName}'s Contacts"),
        scrolledUnderElevation: 8,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          // shrinkWrap: true,
          controller: _scrollController,
          itemCount: widget.petProfileDetails.petContacts.length + 2,
          itemBuilder: (context, index) {
            if (index == widget.petProfileDetails.petContacts.length + 1) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(14, 24, 24, 180),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => const EnterNameDialog(
                        label: "Contact Name",
                        confirmLabel: "Create",
                      ),
                    ).then((value) async {
                      if (value != null && value.isNotEmpty) {
                        Contact newcontact = await createNewPetContact(
                          petProfileId: widget.petProfileDetails.profileId,
                          contactName: value,
                        );
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailsPage(
                                contact: newcontact,
                              ),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        }
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.7)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Add new Contact"),
                    ],
                  ),
                ),
              );
            }
            if (index == 0) {
              return const SizedBox(height: 36);
            }
            return Padding(
              padding: const EdgeInsets.all(24),
              child: ContactListItem(
                contact:
                    widget.petProfileDetails.petContacts.elementAt(index - 1),
                refresh: () {
                  setState(() {});
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
