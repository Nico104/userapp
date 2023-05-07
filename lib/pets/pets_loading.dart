import 'package:flutter/material.dart';
import 'package:userapp/pets/my_pets.dart';
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
    return FutureBuilder(
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
                  child: Text('Error: ${snapshot.error}'),
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
                  child: Text('Awaiting result...'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
