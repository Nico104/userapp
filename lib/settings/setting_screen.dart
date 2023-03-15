import 'package:flutter/material.dart';
import 'package:userapp/init_app.dart';

import '../auth/u_auth.dart';
import '../pet_color/hex_color.dart';
import '../pets/profile_details/c_component_title.dart';
import '../pets/profile_details/c_section_title.dart';
import '../styles/custom_icons_icons.dart';
import '../styles/text_styles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final double settingItemSpacing = 16;
  double _appBarDividerHeight = 0;

  final double _appBarDividerHeightActivated = 2.5;
  final double _appBarElevationActivated = 4;

  // Create a variable
  final _scrollSontroller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _scrollSontroller.addListener(() {
      print(_scrollSontroller.position.pixels);
      bool isTop = _scrollSontroller.position.pixels == 0;
      if (isTop) {
        if (_appBarDividerHeight != 0) {
          setState(() {
            _appBarDividerHeight = 0;
          });
        }
      } else {
        if (_appBarDividerHeight == 0) {
          setState(() {
            _appBarDividerHeight = _appBarDividerHeightActivated;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor("FFFF8F"),
      backgroundColor: HexColor("50ffaf"),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: settingsScreenTitle,
          textAlign: TextAlign.center,
        ),
        actions: [
          Icon(
            Icons.new_releases_outlined,
          ),
          SizedBox(
            width: 8,
          )
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 32,
        ),
        // backgroundColor: HexColor("FFFF8F"),
        backgroundColor: HexColor("50ffaf"),
        scrolledUnderElevation: _appBarElevationActivated,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_appBarDividerHeight),
          child: Container(
            color: Colors.black,
            height: _appBarDividerHeight,
          ),
        ),
      ),
      // body: Center(
      //   child: GestureDetector(
      //     onTap: () {
      //       logout().then(
      //         (value) {
      //           Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(builder: (context) => const InitApp()),
      //               (route) => false);
      //         },
      //       );
      //     },
      //     child: Container(
      //       color: Colors.blue,
      //       width: 100,
      //       height: 60,
      //       child: const Text("Logout"),
      //     ),
      //   ),
      // ),
      body: ListView(
        controller: _scrollSontroller,
        children: [
          const SizedBox(height: 42),
          SettingsContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "General",
                  style: settingsTitle,
                ),
                const SizedBox(height: 28),
                const SettingsItem(
                  label: "Account",
                  leading: Icon(Icons.person_outline),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "My Tags",
                  leading: Icon(Icons.hexagon_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Notifications",
                  leading: Icon(Icons.notifications_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "How to use this app?",
                  leading: Icon(Icons.lightbulb_outline),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),

          //Shop
          SettingsContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shop",
                  style: settingsTitle,
                ),
                const SizedBox(height: 28),
                const SettingsItem(
                  label: "Payment Options",
                  leading: Icon(Icons.payment_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Billing and Shipment",
                  leading: Icon(Icons.delivery_dining),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "My Orders",
                  leading: Icon(Icons.list_alt_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Order and Payment History",
                  leading: Icon(Icons.history),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),

          //Help and Support
          SettingsContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Help and Support",
                  style: settingsTitle,
                ),
                const SizedBox(height: 28),
                const SettingsItem(
                  label: "Report Bug",
                  leading: Icon(Icons.warning_amber_rounded),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Contact us (even for Feedback)",
                  leading: Icon(Icons.notifications),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "FAQ",
                  leading: Icon(Icons.question_answer_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Privacy Contract",
                  leading: Icon(Icons.privacy_tip_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "About",
                  leading: Icon(Icons.question_mark),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),

          //? Vlt in account
          SettingsContainer(
            child: SettingsItem(
              label: "Logout",
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              suffix: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                logout().then(
                  (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InitApp()),
                        (route) => false);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.label,
    required this.leading,
    required this.suffix,
    this.onTap,
  });

  final String label;
  final Widget? leading;
  final Widget? suffix;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            const SizedBox(width: 16),
            Text(
              label,
              style: settingsItem,
            ),
            const Spacer(),
            suffix ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.black,
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
