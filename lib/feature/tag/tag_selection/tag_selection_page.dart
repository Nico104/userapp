import 'package:flutter/material.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
import 'package:userapp/general/utils_general.dart';

import '../../pets/profile_details/models/m_pet_profile.dart';
import '../../pets/profile_details/models/m_tag.dart';
import '../../pets/u_pets.dart';
import '../utils/u_tag.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Finma Tag"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     navigatePerSlide(
      //       context,
      //       AddFinmaTagPage(
      //         petProfileId: widget.petProfile.profileId,
      //       ),
      //       callback: () {
      //         setState(() {});
      //       },
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                "Choose an already existing Finma Tag or simply add a new one",
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () => navigateReplacePerSlide(
                  context,
                  AddFinmaTagPage(
                    petProfile: widget.petProfile,
                  )),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Add new Finma Tag",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Padding(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
                height: 0,
              ),
              padding: EdgeInsets.all(32),
            ),
            Flexible(
              child: FutureBuilder<List<Tag>>(
                future: getUserTags(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      // navigateReplacePerSlide(
                      //     context,
                      //     AddFinmaTagPage(
                      //       petProfile: widget.petProfile,
                      //     ));
                    }
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
      ),
    );
  }
}
