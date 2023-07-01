import 'package:flutter/material.dart';
import 'package:userapp/pet_color/hex_color.dart';

import '../../models/m_contact.dart';
import '../../models/m_contact_descripton.dart';
import 'contact_description_list.dart';

class ContactDescriptionComponent extends StatefulWidget {
  const ContactDescriptionComponent({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<ContactDescriptionComponent> createState() =>
      _ContactDescriptionComponentState();
}

class _ContactDescriptionComponentState
    extends State<ContactDescriptionComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ContactDescriptionList(
                  contact: widget.contact,
                ),
              );
            }).then((value) {
          setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
              color: widget.contact.contactDescription == null
                  ? Colors.grey
                  : HexColor(
                      widget.contact.contactDescription!.contactDescriptionHex),
              width: 1.5),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.contact.contactDescription == null
                  ? "Undefined"
                  : widget.contact.contactDescription!.contactDescriptionLabel,
              style: TextStyle(
                color: widget.contact.contactDescription == null
                    ? Colors.grey
                    : HexColor(widget
                        .contact.contactDescription!.contactDescriptionHex),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: widget.contact.contactDescription == null
                  ? Colors.grey
                  : HexColor(
                      widget.contact.contactDescription!.contactDescriptionHex),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDescriptionListTile extends StatelessWidget {
  const ContactDescriptionListTile({
    super.key,
    required this.color,
    required this.label,
    required this.onSelected,
    required this.isSelected,
  });

  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: color,
      ),
      title: Text(label),
      onTap: () => onSelected(),
    );
  }
}
