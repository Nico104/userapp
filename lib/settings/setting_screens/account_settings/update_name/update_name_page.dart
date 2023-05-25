import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_name/update_name_status.dart';

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
              labelText: "Name",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'I cannot be empty mate';
                } else if (value == widget.currentName) {
                  return 'You are already called ${widget.currentName}';
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
