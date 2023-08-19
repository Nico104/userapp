import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/c_component_padding.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../general/utils_theme/custom_colors.dart';
import '../../../general/utils_theme/custom_text_styles.dart';

//TODO not in use anymore

class EditPagesTabComponent extends StatefulWidget {
  const EditPagesTabComponent({
    super.key,
    required this.petInfo,
    required this.contact,
    required this.document,
    required this.images,
  });

  final Widget petInfo, contact, document, images;

  @override
  State<EditPagesTabComponent> createState() => _EditPagesTabComponentState();
}

class _EditPagesTabComponentState extends State<EditPagesTabComponent> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        VisibilityDetector(
          key: const Key('scoll-edit-tabs'),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            debugPrint(
                'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
          },
          // child: PaddingComponent(
          //   child: Row(
          //     children: [
          //       //! Text to do
          //       TabItem(
          //         label: "Pictures",
          //         isActive: index == 3,
          //         bgColor: getCustomColors(context).accentLight ??
          //             Colors.transparent,
          //         onTap: () {
          //           int myIndex = 3;
          //           if (index != myIndex) {
          //             setState(() {
          //               index = myIndex;
          //             });
          //           }
          //         },
          //       ),
          //       const Spacer(flex: 1),
          //       TabItem(
          //         label: "profileDetailsTabTitlePetInfo".tr(),
          //         isActive: index == 0,
          //         bgColor: getCustomColors(context).accentLight ??
          //             Colors.transparent,
          //         onTap: () {
          //           int myIndex = 0;
          //           if (index != myIndex) {
          //             setState(() {
          //               index = myIndex;
          //             });
          //           }
          //         },
          //       ),
          //       const Spacer(flex: 1),
          //       TabItem(
          //         label: "profileDetailsTabTitleContact".tr(),
          //         isActive: index == 1,
          //         bgColor: getCustomColors(context).accentLight ??
          //             Colors.transparent,
          //         onTap: () {
          //           int myIndex = 1;
          //           if (index != myIndex) {
          //             setState(() {
          //               index = myIndex;
          //             });
          //           }
          //         },
          //       ),
          //       const Spacer(flex: 1),
          //       TabItem(
          //         label: "profileDetailsTabTitleDocument".tr(),
          //         isActive: index == 2,
          //         bgColor: getCustomColors(context).accentLight ??
          //             Colors.transparent,
          //         onTap: () {
          //           int myIndex = 2;
          //           if (index != myIndex) {
          //             setState(() {
          //               index = myIndex;
          //             });
          //           }
          //         },
          //       ),
          //       const Spacer(flex: 8),
          //     ],
          //   ),
          // ),
          child: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
            onTap: (value) {
              // print(value);
              setState(() {
                index = value;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 0),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          },
          child: getPage(index, widget.images, widget.petInfo, widget.contact,
              widget.document),
        )
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.label,
    required this.isActive,
    this.onTap,
    required this.bgColor,
  });

  final String label;
  final bool isActive;
  final Color bgColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //To trigger the Hit Box
        color: Colors.transparent,

        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 15,
                  width: 55,
                  color: isActive ? bgColor : Colors.transparent,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 3, bottom: 0),
              child: Text(
                label,
                style: isActive
                    ? getCustomTextStyles(context).profileDetailsTabLabelActive
                    : getCustomTextStyles(context)
                        .profileDetailsTabLabelInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getPage(
    int index, Widget page1, Widget page2, Widget page3, Widget page4) {
  switch (index) {
    case 0:
      return page1;
    case 1:
      return page2;
    case 2:
      return page3;
    case 3:
      return page4;
    default:
      return page1;
  }
}
