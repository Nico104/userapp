import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
import 'package:userapp/general/utils_general.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

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
  }

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
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w200,
                  fontSize: 18 * 1.5,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
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
            AddFinmaTagHeader(
              petProfile: widget.petProfile,
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
                    //     AddFinmaTagPage(
                    //       petProfile: widget.petProfile,
                    //     ));
                    return SizedBox.shrink();
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
            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }
}
