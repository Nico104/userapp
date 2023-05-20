import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_name/update_name_page.dart';
import 'package:userapp/settings/setting_screens/account_settings/update_useremail/update_useremail_page.dart';

import '../../../pet_color/hex_color.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/util_methods.dart';
import '../../widgets/settings_widgets.dart';
import 'update_password/update_password_page.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final double _appBarElevationActivated = 8;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarAccountSettings".tr()),
      ),
      body: FutureBuilder(
        future: Future.wait([
          getSavedCredentails(),
          getName(),
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
                        suffixText: snapshot.data[1],
                        onTap: () {
                          navigatePerSlide(
                            context,
                            const UpdateNamePage(),
                            callback: () {
                              //reload Current Name
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const SizedBox(height: settingItemSpacing),
                      SettingsItem(
                        label: "Email",
                        leading: const Icon(Icons.email_outlined),
                        suffix: const Icon(Icons.keyboard_arrow_right),
                        suffixText: snapshot.data[0].elementAt(0),
                        onTap: () {
                          navigatePerSlide(
                            context,
                            UpdateUseremailPage(),
                            callback: () {
                              //reload Current Password
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const SizedBox(height: settingItemSpacing),
                      //?Adding Phone
                      // SettingsItem(
                      //   label: "Phone",
                      //   leading: const Icon(Icons.email_outlined),
                      //   suffix: const Icon(Icons.keyboard_arrow_right),
                      //   suffixText: snapshot.data?.elementAt(0),
                      // ),
                      // const SizedBox(height: settingItemSpacing),
                      SettingsItem(
                        label: "Password",
                        leading: const Icon(Icons.password_outlined),
                        suffix: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          navigatePerSlide(
                            context,
                            UpdatePasswordPage(
                              currentPassword: snapshot.data[0].elementAt(1),
                            ),
                            callback: () {
                              //reload Current Password
                              setState(() {});
                            },
                          );
                        },
                      ),
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
