import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_general.dart';
import '../../../../general/widgets/loading_indicator.dart';
import '../../utils/u_settings.dart';
import 'notification_settings_item.dart';
import 'package:userapp/feature/pets/profile_details/models/m_notification_settings.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notificationSettings = await getNotificationSettings();
      setState(() {});
    });
  }

  NotificationSettings? notificationSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleNotificationSettings".tr()),
      ),
      body: notificationSettings == null
          ? const CustomLoadingIndicatior()
          : Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  children: [
                    const SizedBox(height: 42),
                    NotificationSettingsItem(
                      label: "notificationSettings_1_title".tr(),
                      description: "notificationSettings_1_description".tr(),
                      value: notificationSettings!.notification1,
                      setValue: (value) async {
                        setState(() {
                          notificationSettings!.notification1 = value;
                        });
                        await updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationSettings_2_title".tr(),
                      description: "notificationSettings_2_description".tr(),
                      value: notificationSettings!.notification2,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.notification2 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationSettings_3_title".tr(),
                      description: "notificationSettings_3_description".tr(),
                      value: notificationSettings!.notification3,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.notification3 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationSettings_4_title".tr(),
                      description: 'notificationSettings_4_description'.tr(),
                      value: notificationSettings!.notification4,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.notification4 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 52),
                    Text(
                      "notificationSettings_emailNotification_label".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationEmailSettings_1_title".tr(),
                      description:
                          "notificationEmailSettings_1_description".tr(),
                      value: notificationSettings!.email1,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.email1 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationEmailSettings_2_title".tr(),
                      description:
                          "notificationEmailSettings_2_description".tr(),
                      value: notificationSettings!.email2,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.email2 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    NotificationSettingsItem(
                      label: "notificationEmailSettings_3_title".tr(),
                      description:
                          "notificationEmailSettings_3_description".tr(),
                      value: notificationSettings!.email3,
                      setValue: (value) {
                        setState(() {
                          notificationSettings!.email3 = value;
                        });
                        updateNotificationSettings(
                            notificationSettings: notificationSettings!);
                      },
                    ),
                    const SizedBox(height: 32),
                    // SettingsItem(
                    //   label: "notificationSettings_emailNotification_label".tr(),
                    //   leading: const Icon(CustomIcons.notification),
                    //   suffix: const Icon(Icons.keyboard_arrow_right),
                    //   onTap: () {
                    //     navigatePerSlide(
                    //       context,
                    //       EmailNotificationSettings(
                    //         body: Padding(
                    //           padding: const EdgeInsets.only(left: 22, right: 22),
                    //           child: ListView(
                    //             children: [
                    //               const SizedBox(height: 42),
                    //               NotificationSettingsItem(
                    //                 label:
                    //                     "notificationEmailSettings_1_title".tr(),
                    //                 description:
                    //                     "notificationEmailSettings_1_description"
                    //                         .tr(),
                    //                 value: notificationSettings!.email1,
                    //                 setValue: (value) {
                    //                   setState(() {
                    //                     notificationSettings!.email1 = value;
                    //                   });
                    //                   updateNotificationSettings(
                    //                       notificationSettings:
                    //                           notificationSettings!);
                    //                 },
                    //               ),
                    //               const SizedBox(height: 32),
                    //               NotificationSettingsItem(
                    //                 label:
                    //                     "notificationEmailSettings_2_title".tr(),
                    //                 description:
                    //                     "notificationEmailSettings_2_description"
                    //                         .tr(),
                    //                 value: notificationSettings!.email2,
                    //                 setValue: (value) {
                    //                   setState(() {
                    //                     notificationSettings!.email2 = value;
                    //                   });
                    //                   updateNotificationSettings(
                    //                       notificationSettings:
                    //                           notificationSettings!);
                    //                 },
                    //               ),
                    //               const SizedBox(height: 32),
                    //               NotificationSettingsItem(
                    //                 label:
                    //                     "notificationEmailSettings_3_title".tr(),
                    //                 description:
                    //                     "notificationEmailSettings_3_description"
                    //                         .tr(),
                    //                 value: notificationSettings!.email3,
                    //                 setValue: (value) {
                    //                   setState(() {
                    //                     notificationSettings!.email3 = value;
                    //                   });
                    //                   updateNotificationSettings(
                    //                       notificationSettings:
                    //                           notificationSettings!);
                    //                 },
                    //               ),
                    //               const SizedBox(height: 32),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }
}
