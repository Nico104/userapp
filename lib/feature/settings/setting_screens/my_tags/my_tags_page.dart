import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/general/utils_general.dart';
import '../../../../general/widgets/future_error_widget.dart';
import '../../../../general/widgets/loading_indicator.dart';
import '../../../pets/profile_details/models/m_tag.dart';
import '../../../tag/tag_selection/add_tag_header.dart';
import '../../../tag/tag_selection/add_tag_page.dart';
import '../../../tag/tag_single.dart';
import '../../../pets/u_pets.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../tag/utils/u_tag.dart';
import 'my_tags_list_item.dart';
import 'my_tags_list_item_tmp.dart';

class MyTagsSettings extends StatefulWidget {
  const MyTagsSettings({super.key});

  @override
  State<MyTagsSettings> createState() => _MyTagsSettingsState();
}

class _MyTagsSettingsState extends State<MyTagsSettings> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => const AddTagPage(),
    //   //   ),
    //   // ).then((value) {
    //   //   setState(() {});
    //   // });
    //   navigateReplacePerSlide(context, const AddTagPage());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleMyTags".tr()),
      ),
      body: Column(
        children: [
          AddNewTagHeader(
            label: "settingsMyTags_addTagInfo1".tr(),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<List<dynamic>>>(
            future: Future.wait([
              getUserTags(),
              fetchUserPets(),
            ]),
            builder: (BuildContext context,
                AsyncSnapshot<List<List<dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data![0].isEmpty) {
                  // navigateReplacePerSlide(context, const AddTagPage());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    navigateReplacePerSlide(context, const AddTagPage());
                  });
                }
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
                      PetProfileDetails? petProfileDetails =
                          getPetAssignedToTag(
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
                return GridView.builder(
                  itemCount: tags.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: getCrossAxisCount(pictures.length),
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 6,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    PetProfileDetails? petProfileDetails =
                        getPetAssignedToTag(petProfiles, tags.elementAt(index));

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyTagListItem(
                        tag: tags.elementAt(index),
                        petProfileDetails: petProfileDetails,
                        reloadTags: () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                //Error
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => Navigator.push(
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
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
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
