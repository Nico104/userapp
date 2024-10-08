import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/tag/tag_selection/add_tag_page.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../../general/widgets/future_error_widget.dart';
import '../../../general/widgets/loading_indicator.dart';
import '../../pets/profile_details/models/m_pet_profile.dart';
import '../../pets/profile_details/models/m_tag.dart';
import '../utils/u_tag.dart';
import 'add_tag_header.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const AddTagPage(),
      //   ),
      // ).then((value) {
      //   setState(() {});
      // });
      if (widget.petProfile.tag.isEmpty) {
        if ((await future).isEmpty) {
          // navigateReplacePerSlide(context, AddTagPage());  b
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTagPage(
                petProfile: widget.petProfile,
              ),
            ),
          ).then((value) {
            setState(() {});
            // print(value);
            // if (value != null) {
            //   Tag tag = Tag.fromJson(value);
            //   connectTagFromPetProfile(
            //       widget.petProfile.profileId, tag.collarTagId);
            //   // if (value is Tag) {
            //   //   Tag tag = value;
            //   //   connectTagFromPetProfile(
            //   //       widget.petProfile.profileId, tag.collarTagId);
            //   // }
            // }
            // Navigator.pop(context);
          });
        }
      }
    });
  }

  Future<List<Tag>> future = getUserTags();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNicoScrollView(
        // fillRemaining: true,
        title: Text("tagSelectionPage_Title".tr()),
        expandedHeight: 190,
        background: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "tagSelectionPage_Subtitle".tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 12),
              Text(
                "tagSelectionPage_Title".tr(),
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      color: Colors.transparent,
                      fontSize: 20 * 1.5,
                    ),
              ),
            ],
          ),
        ),
        onScroll: () {},
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // AddTailfurTagHeader(
            //   petProfile: widget.petProfile,
            //   subtitle: "addTag_info".tr(),
            // ),
            AddNewTagHeader(
              petProfile: widget.petProfile,
              label: "addTag_info".tr(),
              reloadTags: () {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "tagSelectionPage_ListTitle".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Tag>>(
              future: getUserTags(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null && snapshot.data!.isEmpty) {
                    // navigateReplacePerSlide(
                    //     context,
                    //     AddTailfurTagPage(
                    //       petProfile: widget.petProfile,
                    //     ));
                    // navigateReplacePerSlide(context, const AddTagPage());
                    return const SizedBox.shrink();
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
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }
}
