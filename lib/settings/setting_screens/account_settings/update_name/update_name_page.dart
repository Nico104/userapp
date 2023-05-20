import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_name/update_name_status.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_check_current_email_code.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_check_new_email_code.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_success.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_verify_current_email.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_verify_new_email.dart';

import '../../../../auth/auth_widgets.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({
    super.key,
  });

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  void _updateName() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return UpdateNameStatus(
            name: textEditingController.text,
          );
        }).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Name"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Suddenly a new Name, huh?"),
            SizedBox(height: 05.h),
            CustomTextFormField(
              textEditingController: textEditingController,
              labelText: "Naya Carr",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'I cannot be empty mate';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 05.h),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: CustomBigButton(
                label: "Change Name",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _updateName();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
