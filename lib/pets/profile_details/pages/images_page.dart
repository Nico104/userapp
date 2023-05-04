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

class ProfileDetailsImagePage extends StatefulWidget {
  const ProfileDetailsImagePage({
    super.key,
    required this.getProfileDetails,
    required this.removePetPicture,
    required this.scrollController,
  });

  final PetProfileDetails Function() getProfileDetails;
  final void Function(int) removePetPicture;

  final ScrollController scrollController;

  @override
  State<ProfileDetailsImagePage> createState() =>
      _ProfileDetailsImagePageState();
}

class _ProfileDetailsImagePageState extends State<ProfileDetailsImagePage>
    with SingleTickerProviderStateMixin {
  bool _enableTopTabBar = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
        bottom: _enableTopTabBar
            ? TabBar(
                controller: _tabController,
                dividerColor: Colors.grey.shade400,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
                onTap: (value) {
                  setState(() {});
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PaddingComponent(
              ignoreLeftPadding: true,
              child: Center(
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: kElevationToShadow[4],
                    image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/512"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // SnakeNavigationBar.color(
            //   behaviour: _snakeBarStyle,
            //   snakeShape: _snakeShape,
            //   shape: _bottomBarShape,
            //   padding: _padding,
            //   elevation: 4,

            //   ///configuration for SnakeNavigationBar.color
            //   snakeViewColor: _selectedColor,
            //   selectedItemColor:
            //       _snakeShape == SnakeShape.indicator ? _selectedColor : null,
            //   unselectedItemColor: Colors.blueGrey,

            //   ///configuration for SnakeNavigationBar.gradient
            //   //snakeViewGradient: selectedGradient,
            //   //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
            //   //unselectedItemGradient: unselectedGradient,

            //   // showUnselectedLabels: _showUnselectedLabels,
            //   // showSelectedLabels: _showSelectedLabels,

            //   currentIndex: _index,
            //   // onTap: (index) => setState(() => _index = index),
            //   items: const [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Icons.safety_check), label: 'microphone'),
            //   ],
            // ),
            VisibilityDetector(
              key: const Key('scoll-edit-tabs'),
              onVisibilityChanged: (visibilityInfo) {
                var visiblePercentage = visibilityInfo.visibleFraction * 100;
                debugPrint(
                    'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                if (visiblePercentage == 100) {
                  setState(() {
                    _enableTopTabBar = false;
                  });
                } else {
                  setState(() {
                    _enableTopTabBar = true;
                  });
                }
              },
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.grey.shade400,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
                onTap: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            PaddingComponent(
              ignoreLeftPadding: true,
              child: PetPicturesComponent(
                petPictures: widget.getProfileDetails().petPictures,
                removePetPicture: (value) {
                  widget.removePetPicture(value);
                },
                imageView: _tabController.index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
