import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    as firebaseMessaging;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';
import 'package:userapp/init_app.dart';
import 'package:userapp/feature/settings/setting_screens/contact_us/contact_us.dart';
import 'package:userapp/feature/settings/setting_screens/language_settings/change_language.dart';
import 'package:userapp/feature/settings/setting_screens/notifcation_settings/notification_settings.dart';
import 'package:userapp/feature/settings/setting_screens/theme_settings/theme_settings.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';

import '../auth/u_auth.dart';
import '../../general/utils_color/hex_color.dart';
import '../../general/utils_theme/theme_provider.dart';
import '../coming_soon/coming_soon_page.dart';
import '../../general/utils_general.dart';
import 'setting_screens/account_settings/account_settings.dart';
import 'setting_screens/my_tags/my_tags_page.dart';
import 'widgets/settings_widgets.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "appBarTitleSettings".tr(),
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                // controller: _scrollSontroller,
                children: [
                  const SizedBox(height: 42),
                  SettingsContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "settingsSectionTitleGeneral".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        SettingsItem(
                          label: "settingsItemAccount".tr(),
                          leading: const Icon(Icons.person_outline),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(context, const AccountSettings());
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemMyTags".tr(),
                          leading: const Icon(Icons.hexagon_outlined),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const MyTagsSettings(),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const MyTagsSettings(),
                            //   ),
                            // );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemNotifications".tr(),
                          leading: const Icon(CustomIcons.notification),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const NotificationSettings(),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemThemes".tr(),
                          leading: const Icon(Icons.hexagon_outlined),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ThemeSettings(),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemLangauge".tr(),
                          leading: const Icon(Icons.translate),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ChangeLanguage(),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemHowToUse".tr(),
                          leading: Icon(Icons.lightbulb_outline),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "How To Use"),
                            );
                          },
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
                          "settingsSectionTitleShop".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        SettingsItem(
                          label: "settingsItemGoShop".tr(),
                          leading: Icon(CustomIcons.shopping_bag_8),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "Shop"),
                            );
                          },
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
                          "settingsSectionTitleHelp".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        SettingsItem(
                          label: "settingsItemReportBug".tr(),
                          leading: Icon(Icons.warning_amber_rounded),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "Report Bug"),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemContactUs".tr(),
                          leading: const Icon(CustomIcons.notification),
                          suffix: const Icon(Icons.keyboard_arrow_right),
                          // onTap: () {
                          //   navigatePerSlide(context, const ContactUs());
                          // },
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ContactUs(),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemFAQ".tr(),
                          leading: Icon(Icons.question_answer_outlined),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "FAQ"),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemPrivacy".tr(),
                          leading: Icon(Icons.privacy_tip_outlined),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "Privacy"),
                            );
                          },
                        ),
                        const SizedBox(height: settingItemSpacing),
                        SettingsItem(
                          label: "settingsItemAbout".tr(),
                          leading: Icon(Icons.question_mark),
                          suffix: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ComingSoonPage(title: "About"),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  //? Vlt in account
                  SettingsContainer(
                    child: SettingsItem(
                      label: "settingsItemLogout".tr(),
                      leading: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      suffix: const Icon(Icons.keyboard_arrow_right),
                      onTap: () async {
                        if (!kIsWeb) {
                          if (Platform.isAndroid || Platform.isIOS) {
                            firebaseMessaging.FirebaseMessaging messaging =
                                firebaseMessaging.FirebaseMessaging.instance;
                            await messaging.getToken().then((fcmToken) async {
                              if (fcmToken != null) {
                                await deleteDeviceToken(fcmToken);
                              }
                            });
                          }
                        }

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
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleSettings".tr()),
      ),
      body: ListView(
        // controller: _scrollSontroller,
        children: [
          const SizedBox(height: 42),
          SettingsContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "settingsSectionTitleGeneral".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SettingsItem(
                  label: "settingsItemAccount".tr(),
                  leading: const Icon(Icons.person_outline),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(context, const AccountSettings());
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemMyTags".tr(),
                  leading: const Icon(Icons.hexagon_outlined),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const MyTagsSettings(),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const MyTagsSettings(),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemNotifications".tr(),
                  leading: const Icon(CustomIcons.notification),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const NotificationSettings(),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemThemes".tr(),
                  leading: const Icon(Icons.hexagon_outlined),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ThemeSettings(),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemLangauge".tr(),
                  leading: const Icon(Icons.translate),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ChangeLanguage(),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemHowToUse".tr(),
                  leading: Icon(Icons.lightbulb_outline),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "How To Use"),
                    );
                  },
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
                  "settingsSectionTitleShop".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SettingsItem(
                  label: "settingsItemGoShop".tr(),
                  leading: Icon(CustomIcons.shopping_bag_8),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "Shop"),
                    );
                  },
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
                  "settingsSectionTitleHelp".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SettingsItem(
                  label: "settingsItemReportBug".tr(),
                  leading: Icon(Icons.warning_amber_rounded),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "Report Bug"),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemContactUs".tr(),
                  leading: const Icon(CustomIcons.notification),
                  suffix: const Icon(Icons.keyboard_arrow_right),
                  // onTap: () {
                  //   navigatePerSlide(context, const ContactUs());
                  // },
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "Contact Us"),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemFAQ".tr(),
                  leading: Icon(Icons.question_answer_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "FAQ"),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemPrivacy".tr(),
                  leading: Icon(Icons.privacy_tip_outlined),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "Privacy"),
                    );
                  },
                ),
                const SizedBox(height: settingItemSpacing),
                SettingsItem(
                  label: "settingsItemAbout".tr(),
                  leading: Icon(Icons.question_mark),
                  suffix: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigatePerSlide(
                      context,
                      const ComingSoonPage(title: "About"),
                    );
                  },
                ),
              ],
            ),
          ),

          //? Vlt in account
          SettingsContainer(
            child: SettingsItem(
              label: "settingsItemLogout".tr(),
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              suffix: const Icon(Icons.keyboard_arrow_right),
              onTap: () async {
                if (!kIsWeb) {
                  if (Platform.isAndroid || Platform.isIOS) {
                    firebaseMessaging.FirebaseMessaging messaging =
                        firebaseMessaging.FirebaseMessaging.instance;
                    await messaging.getToken().then((fcmToken) async {
                      if (fcmToken != null) {
                        await deleteDeviceToken(fcmToken);
                      }
                    });
                  }
                }

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
