import 'package:flutter/material.dart';
import 'package:userapp/language/m_language.dart';
import 'my_pets.dart';
import 'profile_details/models/m_pet_profile.dart';
import 'u_pets.dart';

class PetsLoading extends StatelessWidget {
  const PetsLoading({
    super.key,
    required this.setAppBarNotchColor,
  });

  final ValueSetter<Color> setAppBarNotchColor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchUserPets(),
        fetchAvailableLanguages(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0] is List<PetProfileDetails> &&
              snapshot.data[1] is List<Language>) {
            return MyPets(
              petProfiles: snapshot.data[0],
              setAppBarNotchColor: setAppBarNotchColor,
              availableLanguages: snapshot.data[1],
            );
          } else {
            return const Center(child: Text("No Pets, create?"));
          }
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
