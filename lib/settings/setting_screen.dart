import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/init_app.dart';
import 'package:userapp/settings/setting_screens/theme_settings/theme_settings.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../auth/u_auth.dart';
import '../pet_color/hex_color.dart';
import '../styles/text_styles.dart';
import '../theme/theme_provider.dart';
import 'setting_screens/account_settings/account_settings.dart';
import 'setting_screens/my_tags/my_tags_screen.dart';
import 'widgets/settings_widgets.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final double _appBarElevationActivated = 8;

  final _scrollSontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollSontroller.addListener(() {
    // bool isTop = _scrollSontroller.position.pixels == 0;
    // if (isTop) {
    //   if (_appBarDividerHeight != 0) {
    //     setState(() {
    //       _appBarDividerHeight = 0;
    //     });
    //   }
    // } else {
    //   if (_appBarDividerHeight == 0) {
    //     setState(() {
    //       _appBarDividerHeight = _appBarDividerHeightActivated;
    //     });
    //   }
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 28),
                SettingsItem(
                  label: "Account",
                  leading: const Icon(Icons.person_outline),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountSettings(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "My Tags",
                  leading: const Icon(Icons.hexagon_outlined),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyTagsSettings(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Notifications",
                  leading: Icon(CustomIcons.notification),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "Themes",
                  leading: const Icon(Icons.hexagon_outlined),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThemeSettings(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 28),
                const SettingsItem(
                  label: "Go to Shop",
                  leading: Icon(CustomIcons.shopping_bag_8),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 28),
                const SettingsItem(
                  label: "Report Bug",
                  leading: Icon(Icons.warning_amber_rounded),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Contact us (even for Feedback)",
                  leading: Icon(CustomIcons.notification),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "FAQ",
                  leading: Icon(Icons.question_answer_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: settingItemSpacing),
                const SettingsItem(
                  label: "Privacy Contract",
                  leading: Icon(Icons.privacy_tip_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: settingItemSpacing),
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
