import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import '../auth/u_auth.dart';
import '../settings/setting_screen.dart';
import '../theme/custom_text_styles.dart';
import '../utils/util_methods.dart';

class MyPetsNavbar extends StatelessWidget {
  const MyPetsNavbar({super.key, required this.reloadFuture});

  final VoidCallback reloadFuture;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 28,
        ),
        Text(
          // "Welcome back ",
          'welcomeMsg'.tr(),
          style: getCustomTextStyles(context).homeWelcomeMessage,
        ),
        FutureBuilder<String>(
          future: getName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(
                " ${snapshot.data}",
                style: getCustomTextStyles(context).homeWelcomeUser,
              );
            } else if (snapshot.hasError) {
              print(snapshot);
              return Text(
                " dog whisperer",
                style: getCustomTextStyles(context).homeWelcomeUser,
              );
            } else {
              //Loading
              return Text(
                " mucho mucho bro",
                style: getCustomTextStyles(context).homeWelcomeUser,
              );
            }
          },
        ),

        const Spacer(),
        // const Icon(
        //   CustomIcons.notification,
        //   size: 28,
        // ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            navigatePerSlide(
              context,
              const Settings(),
              callback: () => reloadFuture(),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const Settings(),
            //   ),
            // );
          },
          child: const Icon(
            CustomIcons.setting,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }
}
