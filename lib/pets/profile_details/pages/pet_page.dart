import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/fabs/upload_document_fab.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/pages/profile_info_page.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../styles/custom_icons_icons.dart';
import '../../../theme/custom_text_styles.dart';
import '../../../utils/util_methods.dart';
import '../../../utils/widgets/more_button.dart';
import '../../tag/tag_selection/tag_selection_page.dart';
import '../../tag/tags.dart';
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

  @override
  void initState() {
    super.initState();

    _petProfileDetails = widget.petProfileDetails;

    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

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
      appBar: AppBar(
        title: Text("${_petProfileDetails.petName}'s Profile"),
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
                          // debugPrint(
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
                  child: TabBar(
                    key: tabBarKey,
                    controller: tabController,
                    onTap: (value) {
                      //to refresh currentIndex for FloatingActionButton
                      setState(() {});
                      FocusManager.instance.primaryFocus?.unfocus();
                      Scrollable.ensureVisible(tabBarKey.currentContext!);
                    },
                    tabs: const [
                      Tab(icon: Icon(Icons.pets)),
                      Tab(icon: Icon(Icons.image)),
                      Tab(icon: Icon(Icons.file_copy)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ProfileInfoTab(
                        petProfileDetails: _petProfileDetails,
                        setGender: (value) {
                          setState(() {
                            _petProfileDetails.petGender = value;
                          });
                          updatePetProfileCore(_petProfileDetails);
                        },
                      ),
                      ProfileDetailsImageTab(
                        // getProfileDetails: widget.getProfileDetails,
                        profileDetails: _petProfileDetails,
                        removePetPicture: (index) async {
                          await deletePicture(
                              _petProfileDetails.petPictures.elementAt(index));
                          //hekps against 403 from server
                          // widget.reloadFuture.call();
                          // Future.delayed(const Duration(milliseconds: 100))
                          //     .then((value) => refresh());
                          reloadPetProfileDetails();
                        },
                      ),
                      DocumentsTab(
                        documents: _petProfileDetails.petDocuments,
                      ),
                    ],
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
