import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';
import '../../../auth/u_auth.dart';
import '../../../../general/utils_general.dart';
import '../c_pet_name.dart';
import '../models/m_contact.dart';
import '../models/m_pet_profile.dart';
import 'contact_details_page.dart';
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
        title: const Text("Select Contact"),
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
            print(snapshot);
            return const Text(
              "Error loading your Contacts",
            );
          } else {
            //Loading
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
