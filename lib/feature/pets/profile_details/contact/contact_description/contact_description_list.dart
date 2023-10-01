// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../models/m_contact.dart';
// import '../../models/m_contact_descripton.dart';
// import '../u_contact.dart';
// import 'contact_description_list_item.dart';
// import 'd_contact_description_edit.dart';

// class ContactDescriptionList extends StatefulWidget {
//   const ContactDescriptionList({super.key, required this.contact});

//   final Contact contact;

//   @override
//   State<ContactDescriptionList> createState() => _ContactDescriptionListState();
// }

// class _ContactDescriptionListState extends State<ContactDescriptionList> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: fetchAvailableContactDescription(),
//       builder: (BuildContext context,
//           AsyncSnapshot<List<ContactDescription>> snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: snapshot.data!.length + 1,
//             itemBuilder: (context, index) {
//               if (index == snapshot.data!.length) {
//                 // return ContactDescriptionNewListItem();
//                 return ListTile(
//                   leading: const Icon(Icons.add),
//                   title: Text("contactDescriptionCreateNew".tr()),
//                   onTap: () {
//                     createContactDescription(widget.contact.contactId)
//                         .then((value) {
//                       setState(() {
//                         widget.contact.contactDescription = value;
//                       });
//                       showDialog(
//                         context: context,
//                         builder: (_) => ContactDescriptionEditDialog(
//                           contactDescription: value,
//                           onSave: () {
//                             setState(() {
//                               widget.contact.contactDescription = value;
//                             });
//                             connectContactDescription(widget.contact.contactId,
//                                 value.contactDescriptionId);
//                             Navigator.pop(context);
//                           },
//                           onDelete: () {
//                             //Automatically selected
//                             setState(() {
//                               widget.contact.contactDescription = null;
//                             });
//                             deleteContactDescription(value).then((value) {
//                               setState(() {});
//                             });
//                           },
//                         ),
//                       );
//                     });
//                   },
//                 );
//               } else {
//                 bool isSelected = isContactDescriptionSelected(
//                     widget.contact, snapshot.data!.elementAt(index));
//                 return ContactDescriptionListItem(
//                   isSelected: isSelected,
//                   contactDescription: snapshot.data!.elementAt(index),
//                   onSelected: () {
//                     if (!isSelected) {
//                       setState(() {
//                         widget.contact.contactDescription =
//                             snapshot.data!.elementAt(index);
//                       });
//                       connectContactDescription(widget.contact.contactId,
//                           snapshot.data!.elementAt(index).contactDescriptionId);
//                     } else {
//                       setState(() {
//                         widget.contact.contactDescription = null;
//                       });
//                       disconnectContactDescription(
//                         widget.contact.contactId,
//                       );
//                     }
//                     Navigator.pop(context);
//                   },
//                   onSaveEdit: () {
//                     setState(() {
//                       widget.contact.contactDescription =
//                           snapshot.data!.elementAt(index);
//                     });
//                     connectContactDescription(widget.contact.contactId,
//                         snapshot.data!.elementAt(index).contactDescriptionId);
//                     Navigator.pop(context);
//                   },
//                   onDelete: () {
//                     if (isSelected) {
//                       setState(() {
//                         widget.contact.contactDescription = null;
//                       });
//                     }
//                     deleteContactDescription(snapshot.data!.elementAt(index))
//                         .then((value) {
//                       setState(() {});
//                     });
//                   },
//                 );
//               }
//             },
//           );
//         } else if (snapshot.hasError) {
//           print(snapshot);
//           //Error
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 16),
//                   child: Text('UUps'),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           //Loading
//           return const Center(
//             child: SizedBox(
//               width: 60,
//               height: 60,
//               child: CustomLoadingIndicatior(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
