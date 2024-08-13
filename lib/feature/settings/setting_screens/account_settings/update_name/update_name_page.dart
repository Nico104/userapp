import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/feature/settings/setting_screens/account_settings/update_name/update_name_status.dart';

import '../../../../auth/auth_widgets.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({
    super.key,
    required this.currentName,
  });

  final String currentName;

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textEditingController;

  void _updateName() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return UpdateNameStatus(
            displayName: textEditingController.text,
          );
        }).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarSettingsAccountUpdateName".tr()),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("settingsAccountUpdateNameInfoText".tr()),
              SizedBox(height: 05.h),
              CustomTextFormField(
                textEditingController: textEditingController,
                maxLenght: 18,
                labelText: "settingsAccountUpdateNameInputLabel".tr(),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return "textInputErrorEmpty".tr();
                  // } else if (value == widget.currentName) {
                  //   return 'settingsAccountUpdateNameInputErrorAlreadyInUse'
                  //       .tr(namedArgs: {'Karamba': widget.currentName});
                  // } else {
                  //   return null;
                  // }
                },
              ),
              SizedBox(height: 05.h),
              CustomBigButton(
                label: "settingsAccountUpdateNameSave".tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _updateName();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
