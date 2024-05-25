import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../pets/profile_details/models/m_pet_profile.dart';
import 'add_new_tag_widget.dart';
import 'add_tag_tutorial.dart';

class AddTagPage extends StatelessWidget {
  const AddTagPage({
    super.key,
    this.petProfile,
  });

  final PetProfileDetails? petProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNicoScrollView(
        title: const Text("Add Tag"),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddFinmaTagHeader(
              petProfile: null,
              subtitle: "addTag_info1".tr(),
            ),
            Padding(
              padding: const EdgeInsets.all(16 + 8),
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 0.5,
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: const AddTagTutorial(),
            ),
          ],
        ),
        onScroll: () {},
      ),
    );
  }
}
