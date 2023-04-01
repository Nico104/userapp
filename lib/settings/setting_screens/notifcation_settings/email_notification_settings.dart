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
        title: const Text("Email Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: ListView(
          children: const [
            SizedBox(height: 42),
            NotificationSettingsItem(
              label: "Scanned Tag",
              description:
                  "Get Email as soon as one of your Tags has been scanned",
            ),
            SizedBox(height: 32),
            NotificationSettingsItem(
              label: "New Item in Shop",
              description:
                  "Get Email as soon as a new Finma Tag has been released",
            ),
            SizedBox(height: 32),
            NotificationSettingsItem(
              label: "Newsletter",
              description: "Regularly receive our pawsome Newsletter",
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
