import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../c_component_padding.dart';
import '../fabs/upload_image_fab.dart';
import '../models/m_pet_profile.dart';
import '../pictures/c_pictures.dart';
import '../u_profile_details.dart';

class ProfileDetailsImageTab extends StatefulWidget {
  const ProfileDetailsImageTab({
    super.key,
    // required this.getProfileDetails,
    required this.removePetPicture,
    required this.profileDetails,
    // required this.scrollController,
  });

  // final PetProfileDetails Function() getProfileDetails;
  final PetProfileDetails profileDetails;
  final void Function(int) removePetPicture;

  // final ScrollController scrollController;

  @override
  State<ProfileDetailsImageTab> createState() => _ProfileDetailsImageTabState();
}

class _ProfileDetailsImageTabState extends State<ProfileDetailsImageTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: widget.scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 36),
          PetPicturesComponent(
            petPictures: widget.profileDetails.petPictures,
            removePetPicture: (value) {
              widget.removePetPicture(value);
            },
          ),
        ],
      ),
    );
  }
}

// class ImagesTabBar extends StatelessWidget implements PreferredSizeWidget {
//   const ImagesTabBar({super.key, required this.tabController, this.onTap});

//   final TabController tabController;
//   final void Function(int)? onTap;

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       controller: tabController,
//       dividerColor: Colors.grey.shade400,
//       indicatorColor: Colors.black,
//       tabs: const [
//         Tab(icon: Icon(Icons.image)),
//         Tab(icon: Icon(Icons.list)),
//       ],
//       onTap: onTap,
//     );
//   }
// }
