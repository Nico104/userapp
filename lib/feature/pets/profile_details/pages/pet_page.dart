import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/page_transofrm_horizontal.dart';
import 'package:userapp/feature/pets/profile_details/fabs/upload_document_fab.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/pages/profile_info_page.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../general/utils_general.dart';
import '../../../../general/widgets/more_button.dart';
import '../../../tag/tag_selection/tag_selection_page.dart';
import '../../../tag/tags.dart';
import '../../../tag/utils/u_tag.dart';
import '../../page_transform.dart';
import '../../u_pets.dart';
import '../c_pet_name.dart';
import '../d_confirm_delete.dart';
import '../fabs/upload_image_fab.dart';
import '../models/m_tag.dart';
import '../pictures/upload_picture_dialog.dart';
import 'documents_page.dart';
import 'images_page.dart';

class PetPage extends StatefulWidget {
  const PetPage({
    super.key,
    // required this.getProfileDetails,
    required this.showBottomNavBar,
    // required this.reloadFuture,
    required this.setPetName,
    required this.petProfileDetails,
  });

  //? Maybe Variable and fetchFrromServer when needed Updated a la Contact
  final PetProfileDetails petProfileDetails;
  // final PetProfileDetails Function() getProfileDetails;
  final void Function(bool) showBottomNavBar;
  // final VoidCallback reloadFuture;

  final ValueSetter<String> setPetName;

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> with TickerProviderStateMixin {
  late PetProfileDetails _petProfileDetails;

  final double tagDimension = 160;

  bool _headerVisible = true;
  bool _scrollTop = true;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<NestedScrollViewState> nestedScrolViewKey = GlobalKey();
  final tabBarKey = GlobalKey();

  late TabController tabController;

  final PageController _controller = PageController();
  double pageindex = 0;

  @override
  void initState() {
    super.initState();

    _petProfileDetails = widget.petProfileDetails;

    tabController = TabController(
        initialIndex: 0,
        length: 3,
        vsync: this,
        animationDuration: Duration(milliseconds: 250));

    _controller.addListener(() {
      setState(() {
        pageindex = _controller.page ?? 0;
        // _closeExtendedActions();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //For Nested Scroll Views
      nestedScrolViewKey.currentState!.innerController.addListener(() {
        _handleNavBarShown();
      });
      _scrollController.addListener(() {
        _initiateIsTopListener();
        _handleNavBarShown();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _handleNavBarShown() {
    //hideBar
    widget.showBottomNavBar(false);
    EasyDebounce.debounce(
      'handleNavBarShown',
      const Duration(milliseconds: 350),
      () {
        //shwoNavbar
        widget.showBottomNavBar(true);
      },
    );
  }

  void _initiateIsTopListener() {
    bool isTop = _scrollController.position.pixels == 0;
    // print("top: $isTop");
    if (isTop) {
      if (!_scrollTop && mounted) {
        setState(() {
          _scrollTop = true;
        });
      }
    } else {
      if (_scrollTop && mounted) {
        setState(() {
          _scrollTop = false;
        });
      }
    }
  }

  double getScrolledUnderElevation() {
    if (_scrollTop) {
      return 0;
    } else if (!_scrollTop && _headerVisible) {
      return 8;
    } else {
      return 0;
    }
  }

  // void refresh() {
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }
  void reloadPetProfileDetails() async {
    _petProfileDetails = await getPet(_petProfileDetails.profileId);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> reloadTags() async {
    List<Tag> newTags = await getUserProfileTags(_petProfileDetails.profileId);
    setState(() {
      _petProfileDetails.tag = newTags;
    });
  }

  Widget _getMoreButton() {
    return MoreButton(
      moreOptions: [
        ListTile(
          leading: Icon(CustomIcons.delete),
          title: Text("Delete Pet Profile"),
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const ConfirmDeleteDialog(
                label: "Pet Profile",
              ),
            ).then((value) {
              if (value != null) {
                if (value == true) {
                  //TODO test delete from settings menu because of the refresh Profiles on pop()
                  deletePetProfile(_petProfileDetails).then((value) {
                    Navigator.pop(context);
                  });
                }
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        key: nestedScrolViewKey,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // title: const Text('NestedScrollView'),
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              //   onPressed: () => Navigator.of(context).pop(),
              // ),
              pinned: false,
              floating: false,
              stretch: true,
              expandedHeight: 200.0,
              // forceElevated: innerBoxIsScrolled,
              toolbarTextStyle: TextStyle(color: Colors.red),
              titleTextStyle: TextStyle(color: Colors.blue),
              flexibleSpace: FlexibleSpaceBar(
                // title: Text(
                //   'petProfileTitle'
                //       .tr(namedArgs: {'petName': _petProfileDetails.petName}),
                //   style: TextStyle(
                //     fontFamily: 'LibreBaskerville',
                //     fontSize: 20,
                //     color: Colors.black,
                //   ),
                // ),
                // centerTitle: true,
                background: Column(
                  children: [
                    Spacer(),
                    // SizedBox(
                    //   height: 100,
                    // ),
                    Text(
                      'petProfileTitle'.tr(
                          namedArgs: {'petName': _petProfileDetails.petName}),
                      style: TextStyle(
                        fontFamily: 'LibreBaskerville',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ),
      ),
    );
  }

  // @override
  Widget buildd(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("${_petProfileDetails.petName}'s Profile"),
        title: Text('petProfileTitle'
            .tr(namedArgs: {'petName': _petProfileDetails.petName})),
        scrolledUnderElevation: getScrolledUnderElevation(),
      ),
      // extendBodyBehindAppBar: _scrollTop ? true : false,
      floatingActionButton: getFloatingActionButton(tabController.index),

      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: NestedScrollView(
            key: nestedScrolViewKey,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            // allows you to build a list of elements that would be scrolled away till the body reached the top
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 36),
                      Center(
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: 90.w,
                            height: 90.w,
                            // margin: EdgeInsets.only(bottom: tagDimension * 0.69),
                            // margin: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              // boxShadow: kElevationToShadow[4],
                              image: DecorationImage(
                                image:
                                    NetworkImage("https://picsum.photos/512"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            navigatePerSlide(
                              context,
                              TagSelectionPage(
                                petProfile: _petProfileDetails,
                              ),
                              callback: () => reloadTags(),
                            );
                          },
                          child: Tags(
                              collardimension: tagDimension,
                              tag: _petProfileDetails.tag),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 2),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _petProfileDetails.petName,
                                style: getCustomTextStyles(context)
                                    .profileDetailsPetName,
                              ),
                              _petProfileDetails.petGender != Gender.none
                                  ? Text(
                                      getPetTitle(_petProfileDetails.petGender),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => askForPetName(
                                    context,
                                    widget.setPetName,
                                    _petProfileDetails.petName),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 14, bottom: 14, right: 14),
                                  child: Icon(
                                    CustomIcons.edit_square,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 05.w),
                                child: _getMoreButton(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      VisibilityDetector(
                        key: const Key('petpagetabs'),
                        onVisibilityChanged: (visibilityInfo) {
                          var visiblePercentage =
                              visibilityInfo.visibleFraction * 100;
                          // print(
                          //     'Widget ${visibilityInfo.key} is $visiblePercentage% visible');
                          if (visiblePercentage == 0) {
                            if (mounted) {
                              setState(() {
                                _headerVisible = false;
                              });
                            }
                          } else {
                            if (mounted) {
                              setState(() {
                                _headerVisible = true;
                              });
                            }
                          }
                        },
                        child: const SizedBox(height: 36),
                      ),
                    ],
                  ),
                ),
              ];
            },
            // You tab view goes here
            body: Column(
              children: <Widget>[
                Material(
                  elevation: _headerVisible ? 0 : 4,
                  // child: TabBar(
                  //   key: tabBarKey,
                  //   controller: tabController,
                  //   onTap: (value) {
                  //     //to refresh currentIndex for FloatingActionButton
                  //     setState(() {});
                  //     FocusManager.instance.primaryFocus?.unfocus();
                  //     Scrollable.ensureVisible(tabBarKey.currentContext!);
                  //     setState(() {
                  //       pageindex = value.toDouble();
                  //       _controller.animateToPage(value,
                  //           duration: Duration(milliseconds: 250),
                  //           curve: Curves.fastOutSlowIn);
                  //     });
                  //   },
                  //   tabs: const [
                  //     Tab(icon: Icon(Icons.pets)),
                  //     Tab(icon: Icon(Icons.image)),
                  //     Tab(icon: Icon(Icons.file_copy)),
                  //   ],
                  // ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print("dfffdfsaf");
                            FocusManager.instance.primaryFocus?.unfocus();
                            // Scrollable.ensureVisible(tabBarKey.currentContext!);
                            // setState(() {
                            pageindex = 0;
                            _controller.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 125),
                              curve: Curves.fastOutSlowIn,
                            );
                            // });
                          },
                          child: TabElement(
                            isActive: pageindex.round() == 0,
                            label: "Info",
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // Scrollable.ensureVisible(tabBarKey.currentContext!);
                            // setState(() {
                            //   pageindex = 1;
                            //   _controller.animateToPage(
                            //     1,
                            //     duration: const Duration(milliseconds: 125),
                            //     curve: Curves.fastOutSlowIn,
                            //   );
                            // });
                            _controller.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 125),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          child: TabElement(
                            isActive: pageindex.round() == 1,
                            label: "Images",
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // Scrollable.ensureVisible(tabBarKey.currentContext!);
                            // setState(() {
                            pageindex = 2;
                            _controller.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 125),
                              curve: Curves.fastOutSlowIn,
                            );
                            // });
                          },
                          child: TabElement(
                            isActive: pageindex.round() == 2,
                            label: "Docuemnts",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: TabBarView(
                  //   controller: tabController,
                  //   children: [
                  //     ProfileInfoTab(
                  //       petProfileDetails: _petProfileDetails,
                  //       setGender: (value) {
                  //         setState(() {
                  //           _petProfileDetails.petGender = value;
                  //         });
                  //         updatePetProfileCore(_petProfileDetails);
                  //       },
                  //     ),
                  //     ProfileDetailsImageTab(
                  //       // getProfileDetails: widget.getProfileDetails,
                  //       profileDetails: _petProfileDetails,
                  //       removePetPicture: (index) async {
                  //         await deletePicture(
                  //             _petProfileDetails.petPictures.elementAt(index));
                  //         //hekps against 403 from server
                  //         // widget.reloadFuture.call();
                  //         // Future.delayed(const Duration(milliseconds: 100))
                  //         //     .then((value) => refresh());
                  //         reloadPetProfileDetails();
                  //       },
                  //     ),
                  //     DocumentsTab(
                  //       initialDocuments: _petProfileDetails.petDocuments,
                  //       petProfileId: widget.petProfileDetails.profileId,
                  //     ),
                  //   ],
                  // ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        tabController.animateTo(value);
                      },
                      children: [
                        PetProfilePreviewPageTransform(
                          page: pageindex,
                          position: 0,
                          maxRotation: 25,
                          minScaling: 0.65,
                          minOpacity: 0,
                          child: ProfileInfoTab(
                            petProfileDetails: _petProfileDetails,
                            setGender: (value) {
                              setState(() {
                                _petProfileDetails.petGender = value;
                              });
                              updatePetProfileCore(_petProfileDetails);
                            },
                          ),
                        ),
                        ProfileInfoTab(
                          petProfileDetails: _petProfileDetails,
                          setGender: (value) {
                            setState(() {
                              _petProfileDetails.petGender = value;
                            });
                            updatePetProfileCore(_petProfileDetails);
                          },
                        ),
                        PetProfilePreviewPageTransform(
                          page: pageindex,
                          position: 1,
                          maxRotation: 25,
                          minScaling: 0.65,
                          minOpacity: 0,
                          child: ProfileDetailsImageTab(
                            // getProfileDetails: widget.getProfileDetails,
                            profileDetails: _petProfileDetails,
                            removePetPicture: (index) async {
                              await deletePicture(_petProfileDetails.petPictures
                                  .elementAt(index));
                              //hekps against 403 from server
                              // widget.reloadFuture.call();
                              // Future.delayed(const Duration(milliseconds: 100))
                              //     .then((value) => refresh());
                              reloadPetProfileDetails();
                            },
                          ),
                        ),
                        PetProfilePreviewPageTransform(
                          page: pageindex,
                          position: 2,
                          maxRotation: 25,
                          minScaling: 0.65,
                          minOpacity: 0,
                          child: DocumentsTab(
                            initialDocuments: _petProfileDetails.petDocuments,
                            petProfileId: widget.petProfileDetails.profileId,
                          ),
                        ),
                      ],
                      // itemBuilder: (context, position) {
                      //   if (position == widget.petProfiles.length) {
                      //     return PetProfilePreviewPageTransform(
                      //       page: pageindex,
                      //       position: position,
                      //       maxRotation: 35,
                      //       minScaling: 0.1,
                      //       minOpacity: 0,
                      //       //TODO set pageindex 1 after coming back to home
                      //       child: NewPetProfile(
                      //         reloadFuture: widget.reloadFuture,
                      //       ),
                      //     );
                      //   } else {
                      //     return PetProfilePreviewPageTransform(
                      //       page: pageindex,
                      //       position: position,
                      //       maxRotation: 25,
                      //       minScaling: 0.65,
                      //       minOpacity: 0,
                      //       child: PetProfilePreview(
                      //         extendedActions: isExtendedIndexActive(
                      //             activeExtendedActions, position),
                      //         petProfileDetails:
                      //             widget.petProfiles.elementAt(position),
                      //         imageAlignmentOffset:
                      //             -getAlignmentOffset(pageindex, position),
                      //         // imageAlignmentOffset: 0,
                      //         reloadFuture: () => widget.reloadFuture.call(),
                      //         switchExtendedActions: () {
                      //           setState(() {
                      //             if (activeExtendedActions != position) {
                      //               activeExtendedActions = position;
                      //             } else {
                      //               activeExtendedActions = null;
                      //             }
                      //           });
                      //         },
                      //         setPictureLink: (bgPictureLink) {
                      //           // if (_bgPictureLink != bgPictureLink) {
                      //           //   // print("PicturIndex: " +
                      //           //   //     pictueIndex.toString());
                      //           //   EasyDebounce.debounce(
                      //           //     'emailLogwwinPage',
                      //           //     const Duration(milliseconds: 250),
                      //           //     () {
                      //           //       WidgetsBinding.instance
                      //           //           .addPostFrameCallback((_) {
                      //           //         setState(() {
                      //           //           _bgPictureLink =
                      //           //               bgPictureLink;
                      //           //         });
                      //           //       });
                      //           //     },
                      //           //   );
                      //           // }
                      //         },
                      //       ),
                      //     );
                      //   }
                      // },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? getFloatingActionButton(int index) {
    switch (index) {
      case 1:
        return UploadImageFab(
          addPetPicture: (value) async {
            //Loading Dialog Thingy
            BuildContext? dialogContext;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                dialogContext = context;
                return const UploadPictureDialog();
              },
            );
            await uploadPicture(
              _petProfileDetails.profileId,
              value,
              () async {
                // widget.reloadFuture.call();
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => reloadPetProfileDetails());
                //Close Loading Dialog Thingy
                Navigator.pop(dialogContext!);
              },
            );
          },
        );
      case 2:
        return UploadDocumentFab(
          addDocument: (value, filename, documentType, contentType) async {
            // Loading Dialog Thingy
            BuildContext? dialogContext;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                dialogContext = context;
                return const UploadPictureDialog();
              },
            );
            await uploadDocuments(
              _petProfileDetails.profileId,
              value,
              filename,
              documentType,
              contentType,
              () async {
                // widget.reloadFuture.call();
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => reloadPetProfileDetails());
                //Close Loading Dialog Thingy
                Navigator.pop(dialogContext!);
              },
            );
          },
        );
      default:
        return null;
    }
  }
}

class TabElement extends StatelessWidget {
  const TabElement({
    super.key,
    required this.isActive,
    required this.label,
  });

  final bool isActive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(label),
        SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? Colors.pink : Colors.transparent,
          ),
        ),
      ],
    );
  }
}
