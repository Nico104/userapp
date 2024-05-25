import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import '../../../general/utils_theme/theme_provider.dart';
import '../../../general/widgets/future_error_widget.dart';
import '../../auth/u_auth.dart';
import '../../notifications/notifications_icon_widget.dart';
import '../../pets/profile_details/models/m_pet_profile.dart';
import '../../settings/setting_screen.dart';
import '../../../general/utils_theme/custom_text_styles.dart';
import '../../../general/utils_general.dart';

class MyPetsNavbar extends StatefulWidget {
  const MyPetsNavbar(
      {super.key, required this.reloadFuture, required this.petProfileDetails});

  final VoidCallback reloadFuture;

  ///Only used for Theme Selection Page
  final PetProfileDetails petProfileDetails;

  @override
  State<MyPetsNavbar> createState() => _MyPetsNavbarState();
}

class _MyPetsNavbarState extends State<MyPetsNavbar> {
  Widget? title;
  final Duration _duration = const Duration(milliseconds: 1500);

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
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Navigator.push(
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
    await Future.delayed(const Duration(seconds: 12));

    title = Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text(
              "${"myPetsTitleMy".tr()} ",
              style: getCustomTextStyles(context).homeWelcomeMessage,
            ),
            Text(
              "myPetsTitlePets".tr(),
              style: getCustomTextStyles(context).homeWelcomeUser,
            ),
          ],
        );
      },
    );

    // title = Wrap(
    //   alignment: WrapAlignment.start,
    //   children: [
    //     Text(
    //       "myPetsTitleMy".tr() + " ",
    //       style: getCustomTextStyles(context).homeWelcomeMessage,
    //     ),
    //     Text(
    //       "myPetsTitlePets".tr(),
    //       style: getCustomTextStyles(context).homeWelcomeUser,
    //     ),
    //   ],
    // );
    if (mounted) {
      setState(() {});
    }
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
            child: GestureDetector(
              onTap: () {},
              child: AnimatedSwitcher(
                duration: _duration,
                child: title ?? getWelcomeTitle(),
              ),
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
              Settings(
                petProfileDetails: widget.petProfileDetails,
              ),
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
