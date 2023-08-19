import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/contacts_all_list_page.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import '../auth/u_auth.dart';
import '../notifications/notifications_icon_widget.dart';
import '../notifications/notifications_page.dart';
import '../settings/setting_screen.dart';
import '../../general/utils_theme/custom_text_styles.dart';
import '../../general/utils_general.dart';

class MyPetsNavbar extends StatelessWidget {
  const MyPetsNavbar({super.key, required this.reloadFuture});

  final VoidCallback reloadFuture;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 28,
        ),
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                "${'welcomeMsg'.tr()} ",
                style: getCustomTextStyles(context).homeWelcomeMessage,
                // overflow: TextOverflow.visible,
              ),
              FutureBuilder<String>(
                future: getDisplayName(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data}",
                      style: getCustomTextStyles(context).homeWelcomeUser,
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot);
                    return Text(
                      "dog whisperer",
                      style: getCustomTextStyles(context).homeWelcomeUser,
                    );
                  } else {
                    //Loading
                    return Text(
                      "mucho mucho bro",
                      style: getCustomTextStyles(context).homeWelcomeUser,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const NotificationsIcon(
          icon: Icon(
            CustomIcons.notification,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            navigatePerSlide(
              context,
              const AllContactsPage(),
              //? callback needed?
              callback: () => reloadFuture(),
            );
          },
          child: const Icon(
            Icons.people_outline_rounded,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            navigatePerSlide(
              context,
              const Settings(),
              callback: () => reloadFuture(),
            );
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
