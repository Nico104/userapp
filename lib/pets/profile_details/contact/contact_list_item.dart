import 'package:flutter/material.dart';
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/profile_details/models/m_contact_descripton.dart';
import 'package:userapp/utils/util_methods.dart';
import '../../../pet_color/hex_color.dart';
import '../models/m_contact.dart';
import 'contact_details_page.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem(
      {super.key, required this.contact, required this.refreshContacts});

  final Contact contact;
  final double _borderRadius = 32;
  final VoidCallback refreshContacts;

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
              contact: contact,
            ),
            callback: () => refreshContacts(),
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
              _getContactDescriptionWidget(contact.contactDescription),
              const SizedBox(height: 24),
              Text(contact.contactName,
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
                      // borderRadius: BorderRadius.circular(28),
                      image: DecorationImage(
                        image: NetworkImage(_getProfilePictureLink()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 8, 0, 8),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _getDescriptionText(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

  String _getProfilePictureLink() {
    if (contact.contactPictureLink != null) {
      return s3BaseUrl + contact.contactPictureLink!;
    } else {
      return "https://picsum.photos/264";
    }
  }

  List<Widget> _getDescriptionText() {
    List<Widget> list = List.empty(growable: true);

    if (contact.contactTelephoneNumbers.isNotEmpty) {
      if (contact.contactTelephoneNumbers.length > 1) {
        Text phoneNumber = Text(
            "${contact.contactTelephoneNumbers.first.country.countryPhonePrefix} ${contact.contactTelephoneNumbers.first.phoneNumber} and ${contact.contactTelephoneNumbers.length - 1} others");
        list.add(phoneNumber);
      } else {
        Text phoneNumber =
            Text(contact.contactTelephoneNumbers.first.phoneNumber);
        list.add(phoneNumber);
      }
    }
    if (contact.contactEmail != null) {
      Text contactEmail = Text(contact.contactEmail!);
      list.add(contactEmail);
    }
    if (list.length < 2 && contact.contactAddress != null) {
      Text contactAddress = Text(contact.contactAddress!);
      list.add(contactAddress);
    }
    if (list.length < 2 && contact.contactFacebook != null) {
      Text contactFacebook = Text(contact.contactFacebook!);
      list.add(contactFacebook);
    }
    if (list.length < 2 && contact.contactInstagram != null) {
      Text contactInstagram = Text(contact.contactInstagram!);
      list.add(contactInstagram);
    }

    if (list.isEmpty) {
      Text nothingadded =
          const Text("Uups it seems this contact isnt contactable");
      list.add(nothingadded);
    }

    return list;
  }
}
