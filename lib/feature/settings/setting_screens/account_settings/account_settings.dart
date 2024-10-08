import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/feature/settings/setting_screens/account_settings/update_name/update_name_page.dart';
import 'package:userapp/feature/settings/setting_screens/account_settings/update_useremail/update_useremail_page_firebase.dart';

import '../../../../general/utils_general.dart';
import '../../../../general/widgets/future_error_widget.dart';
import '../../../../general/widgets/loading_indicator.dart';
import '../../utils/widgets/settings_widgets.dart';
import 'delete_account/delete_account_page.dart';
import 'update_password/update_password_page.dart';

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
    SignInProviderId? loggedInUserProviderId = getLoggedInUserProviderId();

    if (loggedInUserProviderId != null) {
      switch (loggedInUserProviderId) {
        case SignInProviderId.google:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UpdateSocialSignIn(
                label: "googleSignIn_EditTitle".tr(),
                editAccountLink: "https://myaccount.google.com/",
                icon: const Icon(Icons.alternate_email),
              ),
              const SizedBox(height: settingItemSpacing),
              if (getLoggedInUser()!.email != null)
                // Text(
                //     "You are signed in whith your Google Account with the assigned email address: ${getLoggedInUser()!.email}"),
                Text("googleSignIn_EditInfo".tr(
                    namedArgs: {'Karamba': getLoggedInUser()!.email ?? ""})),
            ],
          );
        case SignInProviderId.password:
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SettingsItem(
                maxLines: 1,
                label: "settingsAccountInformationEmail".tr(),
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
                maxLines: 1,
                label: "settingsAccountInformationPassword".tr(),
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
                        "settingsAccountInformationTitle".tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 28),
                      // SettingsItem(
                      //   label: "settingsAccountInformationName".tr(),
                      //   leading: const Icon(Icons.person),
                      //   suffix: const Icon(Icons.keyboard_arrow_right),
                      //   suffixText: snapshot.data[0],
                      //   onTap: () {
                      //     navigatePerSlide(
                      //       context,
                      //       UpdateNamePage(
                      //         currentName: snapshot.data[0],
                      //       ),
                      //       callback: () {
                      //         //reload Current Name
                      //         setState(() {});
                      //       },
                      //     );
                      //   },
                      // ),
                      // const SizedBox(height: settingItemSpacing),
                      _getAccountSettings(),
                    ],
                  ),
                ),
                SettingsContainer(
                  child: SettingsItem(
                    label: "settingsAccountInformationDeleteAccount".tr(),
                    leading: Icon(
                      Icons.heart_broken_sharp,
                      color: Colors.red.shade700,
                    ),
                    suffix: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      navigatePerSlide(
                        context,
                        const DeleteAccount(),
                        callback: () {
                          //reload Current Name
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot);
            WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FutureErrorWidget(),
                  ),
                ).then((value) => setState(
                      () {},
                    )));
            return const SizedBox.shrink();
          } else {
            //Loading
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CustomLoadingIndicatior(),
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
