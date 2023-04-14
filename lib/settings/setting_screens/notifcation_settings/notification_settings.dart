import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../styles/custom_icons_icons.dart';
import '../../../utils/util_methods.dart';
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
            const NotificationSettingsItem(
              label: "Scanned Tag",
              description:
                  "Get Notification as soon as one of your Tags has been scanned",
            ),
            const SizedBox(height: 32),
            const NotificationSettingsItem(
              label: "New Item in Shop",
              description:
                  "Get Notification as soon as a new Finma Tag has been released",
            ),
            const SizedBox(height: 32),
            const NotificationSettingsItem(
              label: "Updates",
              description:
                  "Get Notification as soon as a new update is available",
            ),
            const SizedBox(height: 32),
            const NotificationSettingsItem(
              label: "Reply",
              description:
                  'Get Notification as soon as we reply to your request in "Contact us"',
            ),
            const SizedBox(height: 52),
            SettingsItem(
              label: "Email Notifications",
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
