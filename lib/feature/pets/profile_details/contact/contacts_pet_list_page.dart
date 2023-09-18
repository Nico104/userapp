// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';
// import '../../../../general/utils_general.dart';
// import '../../../../general/widgets/custom_scroll_view.dart';
// import '../c_pet_name.dart';
// import '../models/m_contact.dart';
// import '../models/m_pet_profile.dart';
// import 'contact_details_page.dart';
// import 'contact_list_item.dart';
// import 'contacts_selection_ist_page.dart';

// class ContactPage extends StatefulWidget {
//   const ContactPage({
//     super.key,
//     required this.petProfileDetails,
//     required this.showBottomNavBar,
//   });

//   final PetProfileDetails petProfileDetails;
//   final void Function(bool) showBottomNavBar;

//   @override
//   State<ContactPage> createState() => _ContactPageState();
// }

// class _ContactPageState extends State<ContactPage> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _scrollController.addListener(() {
//         _handleNavBarShown();
//       });
//     });
//   }

//   void _handleNavBarShown() {
//     //hideBar
//     widget.showBottomNavBar(false);
//     EasyDebounce.debounce(
//       'handleNavBarShown',
//       const Duration(milliseconds: 350),
//       () {
//         //shwoNavbar
//         widget.showBottomNavBar(true);
//       },
//     );
//   }

//   Future<void> refreshContacts() async {
//     List<Contact> contracts =
//         await fetchPetContracts(widget.petProfileDetails.profileId);
//     setState(() {
//       widget.petProfileDetails.petContacts = contracts;
//     });
//   }

//   void addNewContact() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (buildContext) {
//         return Container(
//           margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Theme.of(buildContext).primaryColor,
//             borderRadius: BorderRadius.circular(28),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.list),
//                 title: const Text("Add exisitng Contact"),
//                 onTap: () {
//                   Navigator.pop(buildContext);
//                   navigatePerSlide(
//                     context,
//                     SelectionContactsPage(
//                       alreadyConnectedContacts:
//                           widget.petProfileDetails.petContacts,
//                       petProfileDetails: widget.petProfileDetails,
//                     ),
//                     callback: () => refreshContacts(),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.add),
//                 title: const Text("Create New Contact"),
//                 onTap: () {
//                   Navigator.pop(buildContext);
//                   showDialog(
//                     context: context,
//                     builder: (_) => EnterNameDialog(
//                       title: "contactDetailsChangeContactNameTitle".tr(),
//                       hint: "contactDetailsChangeContactNameHint".tr(),
//                       confirmLabel: "Create",
//                     ),
//                   ).then((value) async {
//                     if (value != null && value.isNotEmpty) {
//                       Contact contact = await createNewContact(
//                         contactName: value,
//                       );
//                       await connectContactToPet(
//                         contactId: contact.contactId,
//                         petProfileId: widget.petProfileDetails.profileId,
//                       );
//                       // refreshContacts();
//                       if (context.mounted) {
//                         navigatePerSlide(
//                           context,
//                           ContactDetailsPage(
//                             contact: contact,
//                             petProfileDetails: widget.petProfileDetails,
//                           ),
//                           callback: () => refreshContacts(),
//                         );
//                       }
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomNicoScrollView(
//         title: Text("Contacts"),
//         expandedHeight: 190,
//         background: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Tabo's",
//                 style: GoogleFonts.openSans(
//                   fontWeight: FontWeight.w200,
//                   fontSize: 18 * 1.5,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 12),
//               Text(
//                 "Contacts",
//                 style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
//                       color: Colors.transparent,
//                       fontSize: 20 * 1.5,
//                     ),
//               ),
//             ],
//           ),
//         ),
//         onScroll: () {},
//         body: Column(
//           // mainAxisSize: MainAxisSize.min,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             // AddFinmaTagHeader(
//             //   petProfile: widget.petProfile,
//             // ),
//             //New Contact
//             Padding(
//               padding: const EdgeInsets.fromLTRB(14, 24, 24, 180),
//               child: GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   addNewContact();
//                 },
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey.withOpacity(0.7)),
//                       child: const Icon(
//                         Icons.add,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text("petContactListAddNewContact".tr()),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Your Finma Tags",
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               controller: _scrollController,
//               itemCount: widget.petProfileDetails.petContacts.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: ContactListItem(
//                     contact:
//                         widget.petProfileDetails.petContacts.elementAt(index),
//                     petProfileDetails: widget.petProfileDetails,
//                     refreshContacts: () {
//                       refreshContacts();
//                     },
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 75.h),
//           ],
//         ),
//       ),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('appBarPetContactList'
//             .tr(namedArgs: {'name': widget.petProfileDetails.petName})),
//         scrolledUnderElevation: 8,
//       ),
//       body: ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//         child: ListView.builder(
//           // shrinkWrap: true,
//           controller: _scrollController,
//           itemCount: widget.petProfileDetails.petContacts.length + 2,
//           itemBuilder: (context, index) {
//             if (index == widget.petProfileDetails.petContacts.length + 1) {
//               //New Contact
//               return Padding(
//                 padding: const EdgeInsets.fromLTRB(14, 24, 24, 180),
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     addNewContact();
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey.withOpacity(0.7)),
//                         child: const Icon(
//                           Icons.add,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text("petContactListAddNewContact".tr()),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             if (index == 0) {
//               return const SizedBox(height: 36);
//             }
//             return Padding(
//               padding: const EdgeInsets.all(24),
//               child: ContactListItem(
//                 contact:
//                     widget.petProfileDetails.petContacts.elementAt(index - 1),
//                 petProfileDetails: widget.petProfileDetails,
//                 refreshContacts: () {
//                   refreshContacts();
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
