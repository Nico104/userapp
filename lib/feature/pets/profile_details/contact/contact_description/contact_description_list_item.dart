// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:userapp/general/utils_color/hex_color.dart';
// import 'package:userapp/feature/pets/profile_details/models/m_contact_descripton.dart';
// import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';

// import 'd_contact_description_edit.dart';

// class ContactDescriptionListItem extends StatelessWidget {
//   const ContactDescriptionListItem({
//     super.key,
//     required this.contactDescription,
//     required this.isSelected,
//     required this.onSelected,
//     required this.onSaveEdit,
//     required this.onDelete,
//   });

//   final ContactDescription contactDescription;
//   final bool isSelected;
//   final VoidCallback onSelected;
//   final VoidCallback onSaveEdit;
//   final VoidCallback onDelete;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(
//         isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
//         color: HexColor(contactDescription.contactDescriptionHex),
//       ),
//       title: Text(contactDescription.contactDescriptionLabel),
//       trailing: GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (_) => ContactDescriptionEditDialog(
//               contactDescription: contactDescription,
//               onDelete: () => onDelete(),
//               onSave: () => onSaveEdit(),
//             ),
//           );
//         },
//         child: const Icon(CustomIcons.edit),
//       ),
//       onTap: () => onSelected(),
//     );
//   }
// }
