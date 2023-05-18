import 'package:flutter/material.dart';
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/profile_details/models/m_contact_descripton.dart';
import 'package:userapp/utils/util_methods.dart';
import '../../../pet_color/hex_color.dart';
import '../models/m_contact.dart';
import 'contact_details_page.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem({
    super.key,
    required this.contact,
    required this.refreshContacts,
  });

  final Contact contact;
  final VoidCallback refreshContacts;

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
              // getContact: () {
              //   print(widget.contact.contactPictureLink);
              //   return widget.contact;
              // },
              // reloadFuture: () => widget.refreshContacts(),
            ),
            callback: () => widget.refreshContacts(),
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
    if (widget.contact.contactEmail != null) {
      Text contactEmail = Text(widget.contact.contactEmail!);
      list.add(contactEmail);
    }
    if (list.length < 2 && widget.contact.contactAddress != null) {
      Text contactAddress = Text(widget.contact.contactAddress!);
      list.add(contactAddress);
    }
    if (list.length < 2 && widget.contact.contactFacebook != null) {
      Text contactFacebook = Text(widget.contact.contactFacebook!);
      list.add(contactFacebook);
    }
    if (list.length < 2 && widget.contact.contactInstagram != null) {
      Text contactInstagram = Text(widget.contact.contactInstagram!);
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
