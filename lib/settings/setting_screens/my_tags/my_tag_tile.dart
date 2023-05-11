import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_tag.dart';
import 'package:userapp/pets/tag/tag_single.dart';
import 'package:userapp/settings/setting_screens/my_tags/try_delete.dart';
import 'package:userapp/theme/custom_colors.dart';

import '../../../pets/profile_details/models/m_pet_profile.dart';
import '../../../pets/profile_details/profile_detail_view.dart';
import '../../../utils/util_methods.dart';
import 'my_tag_tile_buttons.dart';

class MyTagTile extends StatefulWidget {
  const MyTagTile({
    super.key,
    required this.tag,
    this.petProfileDetails,
  });

  final Tag tag;
  final PetProfileDetails? petProfileDetails;

  @override
  State<MyTagTile> createState() => _MyTagTileState();
}

class _MyTagTileState extends State<MyTagTile> {
  final double _collardimension = 120;

  bool isOpen = false;
  bool tryDelete = false;

  final Duration _duration = const Duration(milliseconds: 125);
  final Curve _curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
            tryDelete = false;
          });
        },
        // behavior: HitTestBehavior.deferToChild,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 80),
          child: !tryDelete
              ? Stack(
                  // alignment: isOpen ? Alignment.centerLeft : Alignment.centerLeft,
                  children: [
                    AnimatedPositioned(
                      duration: _duration,
                      curve: _curve,
                      left: isOpen ? null : 0,
                      top: isOpen ? null : 0,
                      right: isOpen ? null : 0,
                      bottom: isOpen ? null : 0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: _duration,
                          curve: _curve,
                          margin: EdgeInsets.only(
                              left: isOpen ? 0 : _collardimension / 2),
                          decoration: BoxDecoration(
                            // color: getCustomColors(context).accent
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              width: 1,
                              color: !isOpen
                                  ? getCustomColors(context).hardBorder ??
                                      Colors.transparent
                                  : getCustomColors(context).lightBorder ??
                                      Colors.transparent,
                              // strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: BorderRadius.circular(28),
                            //The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
                            boxShadow: kElevationToShadow[isOpen ? 8 : 0],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: _duration,
                                curve: _curve,
                                height: (_collardimension - 40),

                                margin: EdgeInsets.only(
                                  left: isOpen
                                      ? 16 + _collardimension + 16 + 12
                                      : _collardimension / 2 + 16,
                                  bottom: isOpen ? 16 : 8,
                                  top: isOpen ? 16 + 16 : 8,
                                  right: isOpen ? 16 : 8,
                                ),
                                // color: Colors.blue,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tag Code",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Assigned to Taco",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedPadding(
                                duration: _duration,
                                curve: _curve,
                                padding: EdgeInsets.only(
                                  top: isOpen ? 42 : 0,
                                  bottom: isOpen ? 28 : 0,
                                  left: isOpen ? 8 : 0,
                                  right: isOpen ? 8 : 0,
                                ),
                                child: AnimatedSwitcher(
                                  duration: _duration,
                                  child: isOpen
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                DeleteTagButton(
                                                  deleteTag: () {
                                                    setState(() {
                                                      tryDelete = true;
                                                    });
                                                  },
                                                  label: "Delete Finma Tag",
                                                ),
                                                GoToProfileButton(
                                                  onTap: () {
                                                    if (widget
                                                            .petProfileDetails !=
                                                        null) {
                                                      navigatePerSlide(
                                                        context,
                                                        PetProfileDetailView(
                                                          petProfileDetails: widget
                                                              .petProfileDetails!,
                                                          reloadFuture: () {
                                                            setState(() {});
                                                          },
                                                          getProfileDetails:
                                                              () {
                                                            return widget
                                                                .petProfileDetails!;
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  label:
                                                      widget.petProfileDetails !=
                                                              null
                                                          ? "Go To Profile"
                                                          : "Create Profile",
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: _duration,
                      curve: _curve,
                      alignment:
                          isOpen ? Alignment.topLeft : Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: isOpen ? 16 : 0,
                        top: isOpen ? 16 : 0,
                        bottom: isOpen ? 8 : 0,
                        right: isOpen ? 8 : 0,
                      ),
                      child: TagSingle(
                        collardimension: _collardimension,
                        picturePath: widget.tag.picturePath,
                      ),
                    )
                  ],
                )
              : TryDelete(
                  cancel: () {
                    setState(
                      () {
                        tryDelete = false;
                      },
                    );
                  },
                  delete: () {},
                ),
        ),
      ),
    );
  }
}
