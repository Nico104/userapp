import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/pets/profile_details/models/m_contact_descripton.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../u_contact.dart';
import 'd_contact_description_edit.dart';

class ContactDescriptionNewListItem extends StatelessWidget {
  const ContactDescriptionNewListItem({
    super.key,
    required this.onSaveEdit,
    required this.onDelete,
    required this.contactId,
  });

  final int contactId;
  final VoidCallback onSaveEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text("Create new"),
      onTap: () {
        createContactDescription(contactId).then(
          (value) {
            showDialog(
              context: context,
              builder: (_) => ContactDescriptionEditDialog(
                contactDescription: value,
                onDelete: () => onDelete(),
                onSave: () => onSaveEdit(),
              ),
            );
          },
        );
      },
    );
  }
}
