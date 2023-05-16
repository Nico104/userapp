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
import '../../tag/tags.dart';
import '../c_pet_name.dart';
import '../fabs/upload_image_fab.dart';
import '../pictures/upload_picture_dialog.dart';
import 'documents_page.dart';
import 'images_page.dart';

class PetPage extends StatefulWidget {
  const PetPage({
    super.key,
    required this.getProfileDetails,
    required this.showBottomNavBar,
    required this.reloadFuture,
    required this.setPetName,
  });

  // final PetProfileDetails petProfileDetails;
  final PetProfileDetails Function() getProfileDetails;
  final void Function(bool) showBottomNavBar;
  final VoidCallback reloadFuture;

  final ValueSetter<String> setPetName;

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> with TickerProviderStateMixin {
  final double tagDimension = 160;

  bool _headerVisible = true;
  bool _scrollTop = true;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //For Nested Scroll Views
      globalKey.currentState!.innerController.addListener(() {
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

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: !_scrollTop
          ? AppBar(
              title: _scrollTop
                  ? null
                  : Text("${widget.getProfileDetails().petName}'s Profile"),
              scrolledUnderElevation: getScrolledUnderElevation(),
            )
          : const BackButton(),
      extendBodyBehindAppBar: _scrollTop ? true : false,
      floatingActionButton: getFloatingActionButton(tabController.index),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: NestedScrollView(
          key: globalKey,
          controller: _scrollController,
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    //Picture Tag
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.w,
                          margin: EdgeInsets.only(bottom: tagDimension * 0.69),
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(14),
                            // boxShadow: kElevationToShadow[4],
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/512"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Tags(
                            collardimension: tagDimension,
                            tag: widget.getProfileDetails().tag),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //Name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.getProfileDetails().petName,
                              style: getCustomTextStyles(context)
                                  .profileDetailsPetName,
                            ),
                            widget.getProfileDetails().petGender != Gender.none
                                ? Text(
                                    getPetTitle(
                                        widget.getProfileDetails().petGender),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                                  widget.getProfileDetails().petName),
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
                        )
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
                elevation: _headerVisible ? 0 : 8,
                child: TabBar(
                  controller: tabController,
                  onTap: (value) {
                    //to refresh currentIndex for FloatingActionButton
                    setState(() {});
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
                      petProfileDetails: widget.getProfileDetails(),
                      setGender: (value) {
                        setState(() {
                          widget.getProfileDetails().petGender = value;
                        });
                        updatePetProfileCore(widget.getProfileDetails());
                      },
                    ),
                    ProfileDetailsImageTab(
                      getProfileDetails: widget.getProfileDetails,
                      removePetPicture: (index) async {
                        await deletePicture(widget
                            .getProfileDetails()
                            .petPictures
                            .elementAt(index));
                        //hekps against 403 from server
                        widget.reloadFuture.call();
                        Future.delayed(const Duration(milliseconds: 100))
                            .then((value) => refresh());
                      },
                    ),
                    DocumentsTab(
                      documents: widget.getProfileDetails().petDocuments,
                    ),
                  ],
                ),
              ),
            ],
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
              widget.getProfileDetails().profileId,
              value,
              () async {
                widget.reloadFuture.call();
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => refresh());
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
              widget.getProfileDetails().profileId,
              value,
              filename,
              documentType,
              contentType,
              () async {
                widget.reloadFuture.call();
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => refresh());
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

class BackButton extends StatelessWidget implements PreferredSizeWidget {
  const BackButton({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final double borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Theme.of(context).primaryColor,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
    ); // Your custom widget implementation.
  }
}
