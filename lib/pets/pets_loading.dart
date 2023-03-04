import 'package:flutter/material.dart';
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
    return FutureBuilder<List<PetProfileDetails>>(
      future: fetchUserPets(),
      builder: (BuildContext context,
          AsyncSnapshot<List<PetProfileDetails>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return MyPets(
              petProfiles: snapshot.data!,
              setAppBarNotchColor: setAppBarNotchColor,
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
