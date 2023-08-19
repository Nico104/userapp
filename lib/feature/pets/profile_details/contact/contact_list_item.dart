import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_contact_descripton.dart';
import 'package:userapp/general/utils_general.dart';
import '../../../../general/utils_color/hex_color.dart';
import '../../u_pets.dart';
import '../models/m_contact.dart';
import '../models/m_pet_profile.dart';
import 'contact_details_page.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem({
    super.key,
    required this.contact,
    required this.refreshContacts,
    this.showConnectedToPets = false,
    this.petProfileDetails,
  });

  final Contact contact;
  final VoidCallback refreshContacts;

  final bool showConnectedToPets;
  final PetProfileDetails? petProfileDetails;

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  final double _borderRadius = 32;

  String _getProfilePictureLink() {
    if (widget.contact.contactPictureLink != null) {
      return s3BaseUrl + widget.contact.contactPictureLink!;
    } else {
      return "https://picsum.photos/264";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: GestureDetector(
        onTap: () {
          navigatePerSlide(
            context,
            ContactDetailsPage(
              contact: widget.contact,
              petProfileDetails: widget.petProfileDetails,
              // getContact: () {
              //   print(widget.contact.contactPictureLink);
              //   return widget.contact;
              // },
              // reloadFuture: () => widget.refreshContacts(),
            ),
            callback: () {
              widget.refreshContacts();
              //To reload PetProfiles
              setState(() {});
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getContactDescriptionWidget(widget.contact.contactDescription),
              const SizedBox(height: 24),
              Text(widget.contact.contactName,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(_getProfilePictureLink()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getDescriptionText(),
                      ),
                    ),
                  ),
                ],
              ),

              //Connected To Pets
              widget.showConnectedToPets
                  ? FutureBuilder<List<PetProfileDetails>>(
                      future: getPetsFromContact(widget.contact.contactId),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PetProfileDetails>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                Wrap(
                                  direction: Axis.horizontal,
                                  children:
                                      _getAssignedToPetsList(snapshot.data!),
                                ),
                              ],
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getAssignedToPetsList(List<PetProfileDetails> pets) {
    List<Widget> list = [
      Text("contactsAssignedTo".tr()),
    ];
    for (int i = 0; i < pets.length; i++) {
      list.add(Text(pets.elementAt(i).petName));
      if (i < pets.length - 1) {
        list.add(const Text(', '));
      }
    }
    return list;
  }

  Widget _getContactDescriptionWidget(ContactDescription? contactDescription) {
    if (contactDescription != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            child: Container(
              height: 5,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                color: HexColor(contactDescription.contactDescriptionHex),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            contactDescription.contactDescriptionLabel,
            style: TextStyle(
              color: HexColor(contactDescription.contactDescriptionHex),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  List<Widget> _getDescriptionText() {
    List<Widget> list = List.empty(growable: true);

    if (widget.contact.contactTelephoneNumbers.isNotEmpty) {
      if (widget.contact.contactTelephoneNumbers.length > 1) {
        Text phoneNumber = Text(
            "${widget.contact.contactTelephoneNumbers.first.country.countryPhonePrefix} ${widget.contact.contactTelephoneNumbers.first.phoneNumber} and ${widget.contact.contactTelephoneNumbers.length - 1} others");
        list.add(phoneNumber);
      } else {
        Text phoneNumber =
            Text(widget.contact.contactTelephoneNumbers.first.phoneNumber);
        list.add(phoneNumber);
      }
    }
    if (isNotNullOrEmpty(widget.contact.contactEmail)) {
      Text contactEmail = Text(widget.contact.contactEmail!);
      list.add(contactEmail);
    }
    if (list.length < 2 && isNotNullOrEmpty(widget.contact.contactAddress)) {
      Text contactAddress = Text(widget.contact.contactAddress!);
      list.add(contactAddress);
    }
    if (list.length < 2 && isNotNullOrEmpty(widget.contact.contactFacebook)) {
      Text contactFacebook = Text(widget.contact.contactFacebook!);
      list.add(contactFacebook);
    }
    if (list.length < 2 && isNotNullOrEmpty(widget.contact.contactInstagram)) {
      Text contactInstagram = Text(widget.contact.contactInstagram!);
      list.add(contactInstagram);
    }

    if (list.isEmpty) {
      Widget nothingadded = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "petContactListNotContactable".tr(),
            ),
          ),
        ],
      );
      list.add(nothingadded);
    }

    return list;
  }
}
