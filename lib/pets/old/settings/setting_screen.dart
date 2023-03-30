// import 'package:flutter/material.dart';
// import 'package:userapp/init_app.dart';

// import '../auth/u_auth.dart';
// import '../pet_color/hex_color.dart';
// import '../styles/text_styles.dart';
// import 'setting_screens/account_settings/account_settings.dart';
// import 'setting_screens/my_tags/my_tags_screen.dart';
// import 'widgets/settings_widgets.dart';

// class Settings extends StatefulWidget {
//   const Settings({super.key});

//   @override
//   State<Settings> createState() => _SettingsState();
// }

// class _SettingsState extends State<Settings> {
//   double _appBarDividerHeight = 0;

//   final double _appBarDividerHeightActivated = 2.5;
//   final double _appBarElevationActivated = 4;

//   final _scrollSontroller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollSontroller.addListener(() {
//       bool isTop = _scrollSontroller.position.pixels == 0;
//       if (isTop) {
//         if (_appBarDividerHeight != 0) {
//           setState(() {
//             _appBarDividerHeight = 0;
//           });
//         }
//       } else {
//         if (_appBarDividerHeight == 0) {
//           setState(() {
//             _appBarDividerHeight = _appBarDividerHeightActivated;
//           });
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor("50ffaf"),
//       appBar: AppBar(
//         title: Text(
//           "Settings",
//           style: settingsScreenTitle,
//           textAlign: TextAlign.center,
//         ),
//         actions: const [
//           Icon(
//             Icons.new_releases_outlined,
//           ),
//           SizedBox(
//             width: 8,
//           )
//         ],
//         actionsIconTheme: const IconThemeData(
//           color: Colors.black,
//           size: 32,
//         ),
//         // backgroundColor: HexColor("FFFF8F"),
//         backgroundColor: HexColor("50ffaf"),
//         scrolledUnderElevation: _appBarElevationActivated,
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(_appBarDividerHeight),
//           child: Container(
//             color: Colors.black,
//             height: _appBarDividerHeight,
//           ),
//         ),
//       ),
//       body: ListView(
//         controller: _scrollSontroller,
//         children: [
//           const SizedBox(height: 42),
//           SettingsContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "General",
//                   style: settingsTitle,
//                 ),
//                 const SizedBox(height: 28),
//                 SettingsItem(
//                   label: "Account",
//                   leading: const Icon(Icons.person_outline),
//                   suffix: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AccountSettings(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 SettingsItem(
//                   label: "My Tags",
//                   leading: const Icon(Icons.hexagon_outlined),
//                   suffix: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const MyTagsSettings(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "Notifications",
//                   leading: Icon(Icons.notifications_outlined),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "How to use this app?",
//                   leading: Icon(Icons.lightbulb_outline),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//               ],
//             ),
//           ),

//           //Shop
//           SettingsContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Shop",
//                   style: settingsTitle,
//                 ),
//                 const SizedBox(height: 28),
//                 const SettingsItem(
//                   label: "Payment Options",
//                   leading: Icon(Icons.payment_outlined),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "Billing and Shipment",
//                   leading: Icon(Icons.delivery_dining),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "My Orders",
//                   leading: Icon(Icons.list_alt_outlined),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "Order and Payment History",
//                   leading: Icon(Icons.history),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//               ],
//             ),
//           ),

//           //Help and Support
//           SettingsContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Help and Support",
//                   style: settingsTitle,
//                 ),
//                 const SizedBox(height: 28),
//                 const SettingsItem(
//                   label: "Report Bug",
//                   leading: Icon(Icons.warning_amber_rounded),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "Contact us (even for Feedback)",
//                   leading: Icon(Icons.notifications),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "FAQ",
//                   leading: Icon(Icons.question_answer_outlined),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "Privacy Contract",
//                   leading: Icon(Icons.privacy_tip_outlined),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//                 const SizedBox(height: settingItemSpacing),
//                 const SettingsItem(
//                   label: "About",
//                   leading: Icon(Icons.question_mark),
//                   suffix: Icon(Icons.keyboard_arrow_right),
//                 ),
//               ],
//             ),
//           ),

//           //? Vlt in account
//           SettingsContainer(
//             child: SettingsItem(
//               label: "Logout",
//               leading: const Icon(
//                 Icons.logout_outlined,
//                 color: Colors.red,
//               ),
//               suffix: const Icon(Icons.keyboard_arrow_right),
//               onTap: () {
//                 logout().then(
//                   (value) {
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const InitApp()),
//                         (route) => false);
//                   },
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 28),
//         ],
//       ),
//     );
//   }
// }
