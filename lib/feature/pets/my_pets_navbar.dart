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

class MyPetsNavbar extends StatefulWidget {
  const MyPetsNavbar({super.key, required this.reloadFuture});

  final VoidCallback reloadFuture;

  @override
  State<MyPetsNavbar> createState() => _MyPetsNavbarState();
}

class _MyPetsNavbarState extends State<MyPetsNavbar> {
  Widget? title;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initTiteSwitch());
  }

  Widget getWelcomeTitle() {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        Text(
          "${'welcomeMsg'.tr()} ",
          style: getCustomTextStyles(context).homeWelcomeMessage,
        ),
        FutureBuilder<String>(
          future: getDisplayName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
    );
  }

  void initTiteSwitch() async {
    await Future.delayed(const Duration(seconds: 5));
    title = Wrap(
      alignment: WrapAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "My ",
          style: TextStyle(
            fontFamily: 'Promt',
            fontWeight: FontWeight.w300,
            fontSize: 24,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Pets",
          style: TextStyle(
            fontFamily: 'Promt',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.black.withOpacity(1),
          ),
        ),
      ],
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 28,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1500),
              child: title ?? getWelcomeTitle(),
            ),
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
              callback: () => widget.reloadFuture(),
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
              callback: () => widget.reloadFuture(),
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
