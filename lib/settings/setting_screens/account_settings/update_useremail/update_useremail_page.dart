import 'package:flutter/material.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_check_current_email_code.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_check_new_email_code.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_success.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_verify_current_email.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_verify_new_email.dart';

///1. You present the editable section where the user can update the email address.
///2.  Once the user changes the email, a confirmation email is sent to the new email address which contains a link to verify the email address. Note that you don't update the email address in database till now.
///3. Once the user verifies the email using the link sent to the new email address (Or a code whichever floats your boat), you update the email address in your backend. Also, note that the link has an expiry time. Beyond the expiry time, the link becomes useless.
///4. As a security measure, you send an email to the old email address which contains a message about the action which is performed recently. Along with the message, you share a help/support link for the user to contact you in case of the action was not performed by him.
///5. If the user contacts you about the unauthorized action in his account, you verify the critical information related to the user and then takes necessary action.

//TODO check with the pages so all use the same strategy of tetx and onchange or textformfield because of confusion? maybe
class UpdateUseremailPage extends StatefulWidget {
  const UpdateUseremailPage({
    super.key,
  });

  @override
  State<UpdateUseremailPage> createState() => _UpdateUseremailPageState();
}

class _UpdateUseremailPageState extends State<UpdateUseremailPage> {
  String? _newEmail;

  int _step = 0;

  Widget _getCurrentStep() {
    switch (_step) {
      case 0:
        return UpdateUseremailVerifyCurrentEmail(
          nextStep: () {
            setState(() {
              _step = 1;
            });
          },
        );
      case 1:
        return UpdateUserEmailCheckCurrentEmailCode(
          nextStep: () {
            setState(() {
              _step = 2;
            });
          },
        );
      case 2:
        return UpdateUseremailVerifyNewEmail(
          nextStep: (newEmail) {
            setState(() {
              _newEmail = newEmail;
              _step = 3;
            });
          },
        );
      case 3:
        return UpdateUsermailNewCurrentEmailCode(
          newEmail: _newEmail!,
          nextStep: () {
            setState(() {
              _step = 4;
            });
          },
        );
      case 4:
        return UpdateUseremailSuccess(
          nextStep: () {
            Navigator.pop(context);
          },
        );
      default:
        return const Text(
            "There appears to be a mistake,\nplease retry in a couple Minutes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Email"),
      ),
      body: _getCurrentStep(),
    );
  }
}
