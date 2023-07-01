import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/contact/u_contact.dart';
import '../../../auth/u_auth.dart';
import '../../../theme/custom_colors.dart';
import '../../../utils/util_methods.dart';
import '../c_pet_name.dart';
import '../models/m_contact.dart';
import '../models/m_pet_profile.dart';
import 'contact_details_page.dart';
import 'contact_list_item.dart';

class AllContactsPage extends StatefulWidget {
  const AllContactsPage({
    super.key,
  });

  @override
  State<AllContactsPage> createState() => _AllContactsPageState();
}

class _AllContactsPageState extends State<AllContactsPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late List<Contact> _contactsList;
  late Future<void> _initContact;

  Future<void> _initContacts() async {
    final List<Contact> contacts = await fetchUserContracts();
    _contactsList = contacts;
  }

  Future<void> _refreshContacts() async {
    final List<Contact> contacts = await fetchUserContracts();
    setState(() {
      _contactsList = contacts;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {});
    });

    _initContact = _initContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getDisplayName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data}'s Contacts");
            } else {
              return const Text("Contacts");
            }
          },
        ),
        scrolledUnderElevation: 8,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: getCustomColors(context).accent,
        tooltip: "Click to create new Contact",
        onPressed: () async {
          showDialog(
            context: context,
            builder: (_) => const EnterNameDialog(
              label: "Contact Name",
              confirmLabel: "Create",
            ),
          ).then((value) async {
            if (value != null && value.isNotEmpty) {
              Contact contact = await createNewContact(
                contactName: value,
              );
              // refreshContacts();
              if (context.mounted) {
                navigatePerSlide(
                  context,
                  ContactDetailsPage(
                    contact: contact,
                  ),
                  callback: () {
                    //Reload Future
                    setState(() {});
                  },
                );
              }
            }
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: FutureBuilder(
        future: _initContact,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return const Center(
                  child: Text('Loading...'),
                );
              }
            case ConnectionState.done:
              {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refreshContacts,
                  child: (_contactsList.isNotEmpty)
                      ? ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: ListView.builder(
                            // shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: _contactsList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const SizedBox(height: 36);
                              }
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: ContactListItem(
                                  showConnectedToPets: true,
                                  contact: _contactsList.elementAt(index - 1),
                                  refreshContacts: () {
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: Image.asset("assets/tmp/contacts.png"),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                "No contacts yet",
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ],
                          ),
                        ),
                );
              }
          }
        },
      ),
    );
  }
}
