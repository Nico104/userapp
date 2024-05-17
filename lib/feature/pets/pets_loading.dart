import 'package:flutter/material.dart';
import 'package:userapp/feature/my_pets/my_pets.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          fetchUserPets(),
          fetchAvailableLanguages(),
          fetchAvailableCountries(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return MyPets(
              petProfiles: snapshot.data[0],
              availableLanguages: snapshot.data[1],
              availableCountries: snapshot.data[2],
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
