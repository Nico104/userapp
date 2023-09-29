import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'notification_settings_item.dart';

class EmailNotificationSettings extends StatefulWidget {
  const EmailNotificationSettings({super.key});

  @override
  State<EmailNotificationSettings> createState() =>
      _EmailNotificationSettingsState();
}

class _EmailNotificationSettingsState extends State<EmailNotificationSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleEmailNotificationSettings".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: ListView(
          children: [
            const SizedBox(height: 42),
            NotificationSettingsItem(
              label: "notificationEmailSettings_1_title".tr(),
              description: "notificationEmailSettings_1_description".tr(),
            ),
            const SizedBox(height: 32),
            NotificationSettingsItem(
              label: "notificationEmailSettings_2_title".tr(),
              description: "notificationEmailSettings_2_description".tr(),
            ),
            const SizedBox(height: 32),
            NotificationSettingsItem(
              label: "notificationEmailSettings_3_title".tr(),
              description: "notificationEmailSettings_3_description".tr(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
