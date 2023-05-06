import 'package:flutter/material.dart';
import 'package:userapp/language/m_language.dart';
import 'package:userapp/pets/my_pets.dart';
import 'profile_details/models/m_pet_profile.dart';
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
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          // List<PetProfileDetails> petProfiles = snapshot.data[0]
          //     .where((PetProfileDetails content) => content.tag.isNotEmpty)
          //     .toList();
          // print("Lenght: " + petProfiles.length.toString());
          // if (petProfiles.isNotEmpty) {
          //   return MyPets(
          //     petProfiles: petProfiles,
          //     setAppBarNotchColor: widget.setAppBarNotchColor,
          //     // availableLanguages: snapshot.data[1],
          //     availableLanguages: snapshot.data[1],
          //     reloadFuture: () => rebuildFuture.call(),
          //   );
          // } else {
          //   return const Center(child: Text("No Pets, create?"));
          // }
          return MyPets(
            // petProfiles: petProfiles,
            petProfiles: snapshot.data[0],
            // setAppBarNotchColor: widget.setAppBarNotchColor,
            availableLanguages: snapshot.data[1],
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
