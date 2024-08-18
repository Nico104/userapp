import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/general/network_globals.dart';
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
        title: Text("addTagAppbarTitle".tr()),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddFinmaTagHeader(
              petProfile: petProfile,
              subtitle: "addTag_info1".tr(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse(shopUrl),
                      mode: LaunchMode.externalApplication);
                },
                child: Column(
                  children: [
                    Text(
                      "addTag_shopinfo1".tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "addTag_shopinfo2".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
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
