import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_general.dart';
import '../../widgets/settings_widgets.dart';
import 'email_notification_settings.dart';
import 'notification_settings_item.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleNotificationSettings".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: ListView(
          children: [
            const SizedBox(height: 42),
            NotificationSettingsItem(
              label: "notificationSettings_1_title".tr(),
              description: "notificationSettings_1_description".tr(),
            ),
            const SizedBox(height: 32),
            NotificationSettingsItem(
              label: "notificationSettings_2_title".tr(),
              description: "notificationSettings_2_description".tr(),
            ),
            const SizedBox(height: 32),
            NotificationSettingsItem(
              label: "notificationSettings_3_title".tr(),
              description: "notificationSettings_3_description".tr(),
            ),
            const SizedBox(height: 32),
            NotificationSettingsItem(
              label: "notificationSettings_4_title".tr(),
              description: 'notificationSettings_4_description'.tr(),
            ),
            const SizedBox(height: 52),
            SettingsItem(
              label: "notificationSettings_emailNotification_label".tr(),
              leading: const Icon(CustomIcons.notification),
              suffix: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                navigatePerSlide(
                  context,
                  const EmailNotificationSettings(),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
