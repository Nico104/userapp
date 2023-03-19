import 'package:flutter/material.dart';
import 'package:userapp/auth/u_auth.dart';

import '../../../pet_color/hex_color.dart';
import '../../../styles/text_styles.dart';
import '../../widgets/settings_widgets.dart';
import 'edit_password.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  double _appBarDividerHeight = 0;

  final double _appBarDividerHeightActivated = 2.5;
  final double _appBarElevationActivated = 4;

  final _scrollSontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollSontroller.addListener(() {
      bool isTop = _scrollSontroller.position.pixels == 0;
      if (isTop) {
        if (_appBarDividerHeight != 0) {
          setState(() {
            _appBarDividerHeight = 0;
          });
        }
      } else {
        if (_appBarDividerHeight == 0) {
          setState(() {
            _appBarDividerHeight = _appBarDividerHeightActivated;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: settingsScreenTitle,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: HexColor("50ffaf"),
        scrolledUnderElevation: _appBarElevationActivated,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_appBarDividerHeight),
          child: Container(
            color: Colors.black,
            height: _appBarDividerHeight,
          ),
        ),
      ),
      backgroundColor: HexColor("50ffaf"),
      body: FutureBuilder(
        future: getSavedCredentails(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
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
                        style: settingsTitle,
                      ),
                      const SizedBox(height: 28),
                      SettingsItem(
                        label: "Email",
                        leading: const Icon(Icons.email_outlined),
                        suffix: const Icon(Icons.keyboard_arrow_right),
                        suffixText: snapshot.data?.elementAt(0),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPasswordPage(
                                currentPassword: snapshot.data!.elementAt(1),
                              ),
                            ),
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