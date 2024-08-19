import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/auth/u_auth.dart';
import 'package:userapp/feature/my_pets/my_pets.dart';
import 'package:userapp/feature/onboarding/onboarding_page.dart';
import 'package:userapp/feature/settings/setting_screens/how_to/how_to_dialog.dart';
import '../../general/widgets/future_error_widget.dart';
import '../../general/widgets/loading_indicator.dart';
import 'u_pets.dart';

class PetsLoading extends StatefulWidget {
  const PetsLoading({
    super.key,
    // required this.setAppBarNotchColor,
  });

  // final ValueSetter<Color> setAppBarNotchColor;

  @override
  State<PetsLoading> createState() => _PetsLoadingState();
}

class _PetsLoadingState extends State<PetsLoading> {
  void rebuildFuture() {
    print("reload");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSeenOnboarding().then((value) {
        if (!value) {
          // navigatePerSlide(
          //   context,
          //   const OnBoarding(),
          //   callback: () async {
          //     await setSeenOnboarding(true);
          //   },
          // );
          Navigator.of(context)
              .push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return const HowToDialog();
                  }))
              .then(
            (value) async {
              await setSeenOnboarding(true);
            },
          );
        }
      });

      print("Changed to" + context.locale.toString());
      //TODO remove this and add a intial asking for language
      updateUserAppLanguageBackendSync(context.locale.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          fetchUserPets(),
          fetchAvailableLanguages(),
          fetchAvailableCountriesLocal(),
          fetchAvailableSocialMedias(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return MyPets(
              petProfiles: snapshot.data[0],
              availableLanguages: snapshot.data[1],
              availableCountries: snapshot.data[2],
              availableSocialMedias: snapshot.data[3],
              reloadFuture: () => rebuildFuture.call(),
            );
          } else if (snapshot.hasError) {
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
                    child: Text('Loading your pets...'),
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
