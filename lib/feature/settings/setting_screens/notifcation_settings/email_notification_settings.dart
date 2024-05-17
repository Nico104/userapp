import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailNotificationSettings extends StatelessWidget {
  const EmailNotificationSettings({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleEmailNotificationSettings".tr()),
      ),
      body: body,
    );
  }
}
