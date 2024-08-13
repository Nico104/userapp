import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    as firebaseMessaging;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/feature/onboarding/onboarding_page.dart';
import 'package:userapp/feature/settings/setting_screens/how_to/how_to_dialog.dart';
import 'package:userapp/feature/settings/setting_screens/theme_settings/theme_selection_page.dart';
import 'package:userapp/feature/settings/setting_screens/contact_us/contact_us.dart';
import 'package:userapp/feature/settings/setting_screens/notifcation_settings/notification_settings.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../general/utils_theme/theme_provider.dart';
import '../../init_app.dart';
import '../auth/u_auth.dart';
import '../coming_soon/coming_soon_page.dart';
import '../../general/utils_general.dart';
import '../language/language_selector.dart';
import '../language/m_language.dart';
import '../pets/profile_details/g_profile_detail_globals.dart';
import '../pets/profile_details/models/m_pet_profile.dart';
import 'setting_screens/account_settings/account_settings.dart';
import 'setting_screens/my_tags/my_tags_page.dart';
import 'utils/widgets/settings_widgets.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Settings extends StatefulWidget {
  const Settings({super.key, required this.petProfileDetails});

  ///Only used for Theme Selection Page
  final PetProfileDetails petProfileDetails;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomNicoScrollView(
          title: Text(
            "appBarTitleSettings".tr(),
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
          onScroll: () {},
          body: Column(
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
                          const NotificationSettingsPage(),
                        );
                      },
                    ),
                    const SizedBox(height: settingItemSpacing),
                    //TODO release Themes / newer Texts styles not well connected with Themes
                    // SettingsItem(
                    //   label: "settingsItemThemes".tr(),
                    //   leading: const Icon(Icons.hexagon_outlined),
                    //   suffix: const Icon(Icons.keyboard_arrow_right),
                    //   onTap: () {
                    //     // navigatePerSlide(
                    //     //   context,
                    //     //   const ThemeSettings(),
                    //     // );

                    //     navigatePerSlide(
                    //       context,
                    //       Consumer<ThemeNotifier>(
                    //         builder: (context, theme, _) {
                    //           return ThemeSelectionPage(
                    //             theme: theme,
                    //             petProfileDetails: widget.petProfileDetails,
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: settingItemSpacing),
                    Hero(
                      tag: "settingsLang",
                      child: SettingsItem(
                        label: "settingsItemLangauge".tr(),
                        leading: const Icon(Icons.translate),
                        suffix: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // navigatePerSlide(
                          //   context,
                          //   const ChangeLanguage(),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageSelector(
                                activeLanguage: getLanguageFromKey(
                                    context.locale.toString())!,
                                unavailableLanguages: const [],
                                availableLanguages: availableLanguages,
                                title: "appBarLangaugeSettings".tr(),
                                heroTag: "settingsLang",
                              ),
                            ),
                          ).then((value) async {
                            if (value is Language) {
                              await context
                                  .setLocale(Locale(value.languageKey));
                              //Wait otherwise Language doesnt update .tr()
                              await Future.delayed(
                                  const Duration(milliseconds: 125));
                              setState(() {});
                            }
                          });
                        },
                      ),
                    ),
                    //TODO solve how to mka eon boarding screen
                    // const SizedBox(height: settingItemSpacing),
                    // SettingsItem(
                    //   label: "Welcome Page".tr(),
                    //   leading: const Icon(Icons.light),
                    //   suffix: const Icon(Icons.keyboard_arrow_right),
                    //   onTap: () {
                    //     navigatePerSlide(
                    //       context,
                    //       const OnBoarding(),
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: settingItemSpacing),
                    SettingsItem(
                      label: "settingsItemHowToUse".tr(),
                      leading: const Icon(Icons.lightbulb_outline),
                      suffix: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return HowToDialog();
                            }));
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => HowToDialog(),
                        // );
                        // navigatePerSlide(
                        //   context,
                        //   const ComingSoonPage(title: "How To Use"),
                        // );
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
                      leading: const Icon(CustomIcons.shopping_bag_8),
                      suffix: const Icon(Icons.keyboard_arrow_right),
                      onTap: () async {
                        // navigatePerSlide(
                        //   context,
                        //   const ComingSoonPage(title: "Shop"),
                        // );
                        await launchUrl(Uri.parse("http://finmapet.com"),
                            mode: LaunchMode.externalApplication);
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
                    // SettingsItem(
                    //   label: "settingsItemReportBug".tr(),
                    //   leading: Icon(Icons.warning_amber_rounded),
                    //   suffix: Icon(Icons.keyboard_arrow_right),
                    //   onTap: () {
                    //     navigatePerSlide(
                    //       context,
                    //       const ComingSoonPage(title: "Report Bug"),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: settingItemSpacing),
                    SettingsItem(
                      label: "settingsItemContactUs".tr(),
                      leading: const Icon(CustomIcons.notification),
                      suffix: const Icon(Icons.keyboard_arrow_right),
                      // onTap: () {
                      //   navigatePerSlide(context, const ContactUs());
                      // },
                      onTap: () {
                        showContactUsOptions(context);
                        // navigatePerSlide(
                        //   context,
                        //   const ContactUs(),
                        // );
                      },
                    ),
                    const SizedBox(height: settingItemSpacing),
                    // SettingsItem(
                    //   label: "settingsItemFAQ".tr(),
                    //   leading: const Icon(Icons.question_answer_outlined),
                    //   suffix: const Icon(Icons.keyboard_arrow_right),
                    //   onTap: () async {
                    //     // navigatePerSlide(
                    //       // context,
                    //     //   const ComingSoonPage(title: "FAQ"),
                    //     // );
                    //     await launchUrl(Uri.parse("http://finmapet.com"),
                    //         mode: LaunchMode.externalApplication);
                    //   },
                    // ),
                    // const SizedBox(height: settingItemSpacing),
                    SettingsItem(
                      label: "settingsItemPrivacy".tr(),
                      leading: const Icon(Icons.privacy_tip_outlined),
                      suffix: const Icon(Icons.keyboard_arrow_right),
                      onTap: () async {
                        // navigatePerSlide(
                        //   context,
                        //   const ComingSoonPage(title: "Privacy"),
                        // );
                        await launchUrl(Uri.parse("http://finmapet.com"),
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    // const SizedBox(height: settingItemSpacing),
                    // SettingsItem(
                    //   label: "settingsItemAbout".tr(),
                    //   leading: const Icon(Icons.question_mark),
                    //   suffix: const Icon(Icons.keyboard_arrow_right),
                    //   onTap: () async {
                    //     // navigatePerSlide(
                    //     //   context,
                    //     //   const ComingSoonPage(title: "About"),
                    //     // );
                    //     await launchUrl(Uri.parse("http://finmapet.com"),
                    //         mode: LaunchMode.externalApplication);
                    //   },
                    // ),
                  ],
                ),
              ),

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

                    // logout();

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

              Padding(
                padding: const EdgeInsets.all(16),
                // child: Text(
                //   "Every change gets saved and uploaded automatically",
                //   style: Theme.of(context).textTheme.labelSmall,
                //   textAlign: TextAlign.center,
                // ),
                child: _buildVersionInfoText(),
              ),
              const SizedBox(height: 28),
            ],
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     color: Theme.of(context).primaryColor,
          //     child:
          //   ),
          // ),
        ),
      ),
    );
  }
}

Widget _buildVersionInfoText() {
  return FutureBuilder<PackageInfo>(
    future: PackageInfo.fromPlatform(),
    builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
      if (snapshot.hasData) {
        return Text(
          "Version: ${snapshot.data!.version}",
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        );
      } else if (snapshot.hasError) {
        return Text(
          "error loading version",
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        );
      } else {
        return Text(
          "Loading Version",
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        );
      }
    },
  );
}
