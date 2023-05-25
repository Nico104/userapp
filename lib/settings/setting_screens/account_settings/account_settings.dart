import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_name/update_name_page.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/oldclasses/update_useremail_page.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_page_firebase.dart';

import '../../../pet_color/hex_color.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/util_methods.dart';
import '../../widgets/settings_widgets.dart';
import 'update_password/update_password_page.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'update_social_sign_in/update_social_sign_in_widget.dart';

// EmailAuthProviderID: password
// PhoneAuthProviderID: phone
// GoogleAuthProviderID: google.com
// FacebookAuthProviderID: facebook.com
// TwitterAuthProviderID: twitter.com
// GitHubAuthProviderID: github.com
// AppleAuthProviderID: apple.com
// YahooAuthProviderID: yahoo.com
// MicrosoftAuthProviderID: hotmail.com

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  Widget _getAccountSettings() {
    firebase_auth.User? loggedInUser =
        firebase_auth.FirebaseAuth.instance.currentUser;

    if (loggedInUser != null) {
      switch (loggedInUser.providerData.first.providerId) {
        case 'google.com':
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const UpdateSocialSignIn(
                label: "Edit Google-Account",
                editAccountLink: "https://myaccount.google.com/",
                icon: Icon(Icons.alternate_email),
              ),
              const SizedBox(height: settingItemSpacing),
              if (loggedInUser.email != null)
                Text(
                    "You are signed in whith your Google Account with the assigned email address: ${loggedInUser.email!}"),
            ],
          );
        case 'password':
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SettingsItem(
                label: "Email",
                leading: const Icon(Icons.email_outlined),
                suffix: const Icon(Icons.keyboard_arrow_right),
                suffixText: getCurrentFirebaseUser()?.email,
                onTap: () {
                  navigatePerSlide(
                    context,
                    const UpdateUseremailFirebasePage(),
                    callback: () {
                      //reload Current Password
                      setState(() {});
                    },
                  );
                },
              ),
              const SizedBox(height: settingItemSpacing),
              SettingsItem(
                label: "Password",
                leading: const Icon(Icons.password_outlined),
                suffix: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  navigatePerSlide(
                    context,
                    const UpdatePasswordPage(),
                    callback: () {
                      //reload Current Password
                      // setState(() {});
                    },
                  );
                },
              ),
            ],
          );
      }
    }

    //Error man or something
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarAccountSettings".tr()),
      ),
      body: FutureBuilder(
        future: Future.wait([
          // getProviderId(),
          getDisplayName(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                const SizedBox(height: 42),
                SettingsContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Information",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 28),
                      SettingsItem(
                        label: "Name",
                        leading: const Icon(Icons.person),
                        suffix: const Icon(Icons.keyboard_arrow_right),
                        suffixText: snapshot.data[0],
                        onTap: () {
                          navigatePerSlide(
                            context,
                            UpdateNamePage(
                              currentName: snapshot.data[0],
                            ),
                            callback: () {
                              //reload Current Name
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const SizedBox(height: settingItemSpacing),
                      _getAccountSettings(),
                    ],
                  ),
                ),
                SettingsContainer(
                  child: SettingsItem(
                    label: "Delete Account",
                    leading: Icon(
                      Icons.heart_broken_sharp,
                      color: Colors.red.shade700,
                    ),
                    suffix: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                const SizedBox(height: 28),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot);
            //Error
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Account Information: ${snapshot.error}'),
                  ),
                ],
              ),
            );
          } else {
            //Loading
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting Account Data...'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
