import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/my_pets/my_pets_navbar/quick_menu.dart';
import 'package:userapp/feature/pets/profile_details/contact/contacts_all_list_page.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import '../../../general/widgets/future_error_widget.dart';
import '../../auth/u_auth.dart';
import '../../notifications/notifications_icon_widget.dart';
import '../../notifications/notifications_page.dart';
import '../../settings/setting_screen.dart';
import '../../../general/utils_theme/custom_text_styles.dart';
import '../../../general/utils_general.dart';

class MyPetsNavbar extends StatefulWidget {
  const MyPetsNavbar({super.key, required this.reloadFuture});

  final VoidCallback reloadFuture;

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
              // return AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       'Friend',
              //       textStyle: getCustomTextStyles(context).homeWelcomeUser,
              //       speed: const Duration(milliseconds: 175),
              //     ),
              //     TypewriterAnimatedText(
              //       "${snapshot.data}",
              //       textStyle: getCustomTextStyles(context).homeWelcomeUser,
              //       speed: const Duration(milliseconds: 175),
              //     ),
              //   ],
              //   totalRepeatCount: 1,
              //   pause: const Duration(milliseconds: 500),
              //   displayFullTextOnTap: true,
              //   stopPauseOnTap: true,
              // );
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
    // title = const SizedBox.shrink();
    // if (mounted) {
    //   setState(() {});
    // }
    // await Future.delayed(_duration);
    title = Wrap(
      alignment: WrapAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        // AnimatedTextKit(
        //   animatedTexts: [
        //     TypewriterAnimatedText(
        //       'My ',
        //       textStyle: getCustomTextStyles(context).homeWelcomeMessage,
        //       speed: const Duration(milliseconds: 350),
        //     ),
        //   ],
        //   totalRepeatCount: 1,
        //   pause: const Duration(seconds: 10),
        //   displayFullTextOnTap: true,
        //   stopPauseOnTap: true,
        // ),
        Text(
          "myPetsTitleMy".tr() + " ",
          // style: TextStyle(
          //   fontFamily: 'Promt',
          //   fontWeight: FontWeight.w300,
          //   fontSize: 22,
          //   color: Colors.black.withOpacity(0.7),
          // ),
          style: getCustomTextStyles(context).homeWelcomeMessage,
        ),
        // SizedBox(height: 4),
        // AnimatedTextKit(
        //   animatedTexts: [
        //     TypewriterAnimatedText(
        //       'Pets',
        //       textStyle: getCustomTextStyles(context).homeWelcomeUser,
        //       speed: const Duration(milliseconds: 350),
        //     ),
        //   ],
        //   totalRepeatCount: 1,
        //   pause: const Duration(seconds: 10),
        //   displayFullTextOnTap: true,
        //   stopPauseOnTap: true,
        // ),
        Text(
          "myPetsTitlePets".tr(),
          // style: TextStyle(
          //   fontFamily: 'Promt',
          //   fontWeight: FontWeight.w600,
          //   fontSize: 22,
          //   color: Colors.black.withOpacity(1),
          // ),
          style: getCustomTextStyles(context).homeWelcomeUser,
        ),
      ],
    );
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
              onTap: () {
                // Navigator.of(context).push(
                //   PageRouteBuilder(
                //     opaque: false,
                //     barrierDismissible: true,
                //     pageBuilder: (BuildContext context, _, __) {
                //       return const QuickMenu(
                //         heroTag: "quickMenu",
                //       );
                //     },
                //   ),
                // );
              },
              child: AnimatedSwitcher(
                duration: _duration,
                child: title ?? getWelcomeTitle(),
              ),
              // child: AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       'Welcome Pupu!',
              //       textStyle: const TextStyle(
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       speed: const Duration(milliseconds: 200),
              //     ),
              //     TypewriterAnimatedText(
              //       'My Pets',
              //       textStyle: const TextStyle(
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       speed: const Duration(milliseconds: 350),
              //     ),
              //   ],
              //   totalRepeatCount: 1,
              //   pause: const Duration(seconds: 10),
              //   displayFullTextOnTap: true,
              //   stopPauseOnTap: true,
              // ),
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
        // GestureDetector(
        //   onTap: () {
        //     navigatePerSlide(
        //       context,
        //       const AllContactsPage(),
        //       //? callback needed?
        //       callback: () => widget.reloadFuture(),
        //     );
        //   },
        //   child: const Icon(
        //     Icons.people_outline_rounded,
        //     size: 28,
        //   ),
        // ),
        // const SizedBox(width: 16),
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
