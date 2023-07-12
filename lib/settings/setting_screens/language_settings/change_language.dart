import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/auth_widgets.dart';

import '../../../pets/profile_details/widgets/custom_textformfield.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarLangaugeSettings".tr()),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: ListView(
            children: [
              TextButton(
                onPressed: () {
                  context.setLocale(Locale('en', 'US'));
                },
                child: Text("English"),
              ),
              TextButton(
                onPressed: () {
                  context.setLocale(Locale('de', 'DE'));
                },
                child: Text("Deutsch"),
              ),
            ],
          )),
    );
  }
}
