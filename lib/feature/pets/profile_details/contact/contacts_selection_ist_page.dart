import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';
import '../../../../general/widgets/future_error_widget.dart';
import '../../../../general/widgets/loading_indicator.dart';
import '../models/m_contact.dart';
import '../models/m_pet_profile.dart';
import 'contact_list_item.dart';

class SelectionContactsPage extends StatefulWidget {
  const SelectionContactsPage({
    super.key,
    required this.alreadyConnectedContacts,
    required this.petProfileDetails,
  });

  final PetProfileDetails petProfileDetails;
  final List<Contact> alreadyConnectedContacts;

  @override
  State<SelectionContactsPage> createState() => _SelectionContactsPageState();
}

class _SelectionContactsPageState extends State<SelectionContactsPage> {
  List<Contact> _filterUsedContacts(List<Contact> contacts) {
    for (Contact contact in contacts) {
      for (Contact usedContact in widget.alreadyConnectedContacts) {
        if (contact.contactId == usedContact.contactId) {
          contacts.remove(contact);
        }
      }
    }
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contactsSelectionIstPage_selectcontact".tr()),
        scrolledUnderElevation: 8,
      ),
      body: FutureBuilder<List<Contact>>(
        future: fetchUserContracts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            List<Contact> contacts = _filterUsedContacts(snapshot.data!);
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox(height: 36);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: InkWell(
                      onTap: () async {
                        await connectContactToPet(
                          contactId: contacts.elementAt(index - 1).contactId,
                          petProfileId: widget.petProfileDetails.profileId,
                        );
                        Navigator.pop(context);
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child: ContactListItem(
                          showConnectedToPets: true,
                          contact: contacts.elementAt(index - 1),
                          refreshContacts: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(
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
            return const CustomLoadingIndicatior();
          }
        },
      ),
    );
  }
}
