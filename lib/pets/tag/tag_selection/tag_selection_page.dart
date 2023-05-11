import 'package:flutter/material.dart';
import 'package:userapp/pets/tag/tag_selection/tag_selection_list.dart';
import 'package:userapp/utils/util_methods.dart';

import '../../profile_details/models/m_pet_profile.dart';
import '../../profile_details/models/m_tag.dart';
import '../../u_pets.dart';
import 'add_tag_page.dart';

class TagSelectionPage extends StatefulWidget {
  const TagSelectionPage({
    super.key,
    required this.petProfile,
  });

  final PetProfileDetails petProfile;

  @override
  State<TagSelectionPage> createState() => _TagSelectionPageState();
}

class _TagSelectionPageState extends State<TagSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Finma Tag"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatePerSlide(
            context,
            AddFinmaTagPage(
              petProfileId: widget.petProfile.profileId,
            ),
            callback: () {
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FutureBuilder<List<Tag>>(
              future: getUserTags(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
                if (snapshot.hasData) {
                  return TagSelectionList(
                    userTags: snapshot.data!,
                    petProfile: widget.petProfile,
                    reloadUserTags: () {
                      print("reload user tags");
                      setState(() {});
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
          ),
        ],
      ),
    );
  }
}
