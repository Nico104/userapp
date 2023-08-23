import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import '../../../pets/profile_details/models/m_tag.dart';
import '../../../tag/tag_single.dart';
import '../../../pets/u_pets.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../tag/utils/u_tag.dart';
import 'my_tags_list_item.dart';

class MyTagsSettings extends StatefulWidget {
  const MyTagsSettings({super.key});

  @override
  State<MyTagsSettings> createState() => _MyTagsSettingsState();
}

class _MyTagsSettingsState extends State<MyTagsSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleMyTags".tr()),
      ),
      body: FutureBuilder<List<List<dynamic>>>(
        future: Future.wait([
          getUserTags(),
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
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(height: 42),
                    ],
                  );
                } else {
                  PetProfileDetails? petProfileDetails = getPetAssignedToTag(
                      petProfiles, tags.elementAt(index - 1));

                  return MyTagListItem(
                    tag: tags.elementAt(index - 1),
                    petProfileDetails: petProfileDetails,
                    reloadTags: () {
                      setState(() {});
                    },
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
