import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import '../../../pets/profile_details/models/m_tag.dart';
import '../../../pets/tag/tag_single.dart';
import '../../../pets/u_pets.dart';
import '../../../theme/custom_colors.dart';

class MyTagsSettings extends StatelessWidget {
  const MyTagsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tags"),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<List<dynamic>>>(
        future: Future.wait([
          fetchUserTags(),
          fetchUserPets(),
        ]),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<dynamic>>> snapshot) {
          if (snapshot.hasData) {
            List<Tag> tags = snapshot.data?.first as List<Tag>;
            List<PetProfileDetails> petProfiles =
                snapshot.data?.last as List<PetProfileDetails>;
            return ListView.builder(
              //+1 to give initialPadding
              itemCount: tags.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(height: 42),
                    ],
                  );
                } else {
                  int position = index - 1;
                  PetProfileDetails? petProfileDetails = getPetAssignedToTag(
                      petProfiles, tags.elementAt(position));

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Material(
                      borderRadius: BorderRadius.circular(14),
                      // elevation: 6,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // border: Border.all(
                          //   width: 1,
                          //   color: getCustomColors(context).lightBorder ??
                          //       Colors.transparent,
                          //   // strokeAlign: BorderSide.strokeAlignOutside,
                          // ),
                          borderRadius: BorderRadius.circular(14),
                          // boxShadow: [
                          // BoxShadow(
                          //   color: getCustomColors(context).lightShadow ??
                          //       Colors.transparent,
                          //   // blurRadius: 6,
                          //   // spreadRadius: 5,
                          //   // blurRadius: 7,
                          //   // offset: const Offset(1, 3),
                          //   // blurRadius: 4,
                          //   // offset: Offset(4, 8),
                          //   blurRadius:
                          //       2.0, // has the effect of softening the shadow
                          //   spreadRadius:
                          //       0.0, // has the effect of extending the shadow
                          //   offset: Offset(
                          //     1, // horizontal, move right 10
                          //     3, // vertical, move down 10
                          //   ),
                          // ),
                          // BoxShadow(
                          //   color: getCustomColors(context).shadow ??
                          //       Colors.transparent,
                          //   // blurRadius: 6,
                          //   // spreadRadius: 5,
                          //   // blurRadius: 7,
                          //   // offset: const Offset(1, 3),
                          //   // blurRadius: 4,
                          //   // offset: Offset(4, 8),
                          //   blurRadius:
                          //       5.0, // has the effect of softening the shadow
                          //   spreadRadius:
                          //       2.0, // has the effect of extending the shadow
                          //   offset: Offset(
                          //     1, // horizontal, move right 10
                          //     3, // vertical, move down 10
                          //   ),
                          // ),
                          // BoxShadow(
                          //   color: getCustomColors(context).lightShadow ??
                          //       Colors.transparent,
                          //   // blurRadius: 6,
                          //   // spreadRadius: 5,
                          //   // blurRadius: 7,
                          //   // offset: const Offset(1, 3),
                          //   // blurRadius: 4,
                          //   // offset: Offset(4, 8),
                          //   blurRadius:
                          //       15.0, // has the effect of softening the shadow
                          //   spreadRadius:
                          //       -2.0, // has the effect of extending the shadow
                          //   offset: Offset(
                          //     1, // horizontal, move right 10
                          //     3, // vertical, move down 10
                          //   ),
                          // ),
                          // ],
                          boxShadow: kElevationToShadow[3],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TagSingle(
                              tagPersonalisation: tags
                                  .elementAt(position)
                                  .collarTagPersonalisation,
                              collardimension: 95,
                            ),
                            const Spacer(),
                            (petProfileDetails != null)
                                ? Text("${petProfileDetails.petName}'s")
                                : const SizedBox(),
                            // const Spacer(flex: 8),
                            // getSelectionIcon(widget.tagSelection),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
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
      ),
    );
  }
}

PetProfileDetails? getPetAssignedToTag(
    List<PetProfileDetails> userPets, Tag tag) {
  if (tag.petProfileId != null) {
    for (PetProfileDetails petProfileDetails in userPets) {
      if (petProfileDetails.profileId == tag.petProfileId) {
        return petProfileDetails;
      }
    }
  }
  return null;
}
