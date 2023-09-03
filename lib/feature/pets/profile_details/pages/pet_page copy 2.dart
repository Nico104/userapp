import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/page_transofrm_horizontal.dart';
import 'package:userapp/feature/pets/profile_details/fabs/upload_document_fab.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/pages/profile_info_page.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../general/utils_general.dart';
import '../../../../general/widgets/more_button.dart';
import '../../../tag/tag_selection/tag_selection_page.dart';
import '../../../tag/tags.dart';
import '../../../tag/utils/u_tag.dart';
import '../../page_transform.dart';
import '../../u_pets.dart';
import '../c_pet_name.dart';
import '../contact/contacts_pet_list_page.dart';
import '../d_confirm_delete.dart';
import '../fabs/upload_image_fab.dart';
import '../models/m_tag.dart';
import '../pictures/upload_picture_dialog.dart';
import 'custom_flexible_space_bar.dart';
import 'documents_page.dart';
import 'edit_detail_pages/basic_information_page.dart';
import 'edit_detail_pages/description_page.dart';
import 'images_page.dart';
import 'dart:math' as math;

class PetPage2 extends StatefulWidget {
  const PetPage2({
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
  State<PetPage2> createState() => _PetPage2State();
}

class _PetPage2State extends State<PetPage2> with TickerProviderStateMixin {
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
      _scrollController.addListener(() {
        _initiateIsTopListener();
        _handleNavBarShown();

        // _scrollController.position.userScrollDirection
        debugPrint(_scrollController.position.userScrollDirection.toString());
        _handleScrollTilt(_scrollController.position.userScrollDirection);
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

  double _tiltAngle = 0;
  // final double maxTilt = 0.02;
  final double maxTilt = 0.0;

  void _handleScrollTilt(ScrollDirection scrollDirection) {
    //hideBar
    // widget.showBottomNavBar(false);
    if (scrollDirection == ScrollDirection.forward && _tiltAngle != -maxTilt) {
      setState(() {
        _tiltAngle = -maxTilt;
      });
    } else if (scrollDirection == ScrollDirection.reverse &&
        _tiltAngle != maxTilt) {
      setState(() {
        _tiltAngle = maxTilt;
      });
    }
    EasyDebounce.debounce(
      '_handleScrollTilt',
      const Duration(milliseconds: 350),
      () {
        if (_tiltAngle != 0) {
          setState(() {
            _tiltAngle = 0;
          });
        }
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

  static Matrix4 _pmat(num pv) {
    return Matrix4(
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      pv * 0.001,
      0.0,
      0.0,
      0.0,
      1.0,
    );
  }

  Matrix4 perspective = _pmat(1.0);

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: 140.0,
              actions: [
                Icon(Icons.more_horiz),
                SizedBox(width: 16),
              ],
              // automaticallyImplyLeading: false,
              flexibleSpace: MyFlexibleSpaceBar(
                titlePaddingTween: EdgeInsetsTween(
                    begin: EdgeInsets.only(left: 16.0, bottom: 16),
                    end: EdgeInsets.only(left: 72.0, bottom: 16)),
                title: Text('petProfileTitle'
                    .tr(namedArgs: {'petName': _petProfileDetails.petName})),
                // titlePadding: EdgeInsets.all(0), centerTitle: false,
                // centerTitle: true,
                // background: FlutterLogo(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 28),
                  Row(
                    children: [
                      const GridSpacing(),
                      Expanded(
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  color: Colors.blue,
                                  // border: Border.all(
                                  //   width: 0,
                                  //   color:
                                  //       getCustomColors(context).hardBorder ??
                                  //           Colors.transparent,
                                  //   // strokeAlign: BorderSide.strokeAlignOutside,
                                  // ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: kElevationToShadow[6],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Image.asset(
                                          "assets/details_illustartions/lost_dog_1_cut.png",
                                          scale: 2.5,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GridSpacing(),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                "Not Lost",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(1, -0.35),
                                        child: Row(
                                          children: [
                                            Spacer(
                                              flex: 3,
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Text(
                                                  "Mark Tabo as lost",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 16,
                                                    color: Colors.white
                                                        .withOpacity(0.54),
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const GridSpacing(),
                            OpenContainer(
                              closedBuilder: (context, action) => Transform(
                                alignment: FractionalOffset.center,
                                transform: perspective.scaled(1.0, 1.0, 1.0)
                                  ..rotateX(_tiltAngle)
                                  ..rotateY(0.0)
                                  ..rotateZ(0.0),
                                child: AspectRatio(
                                  aspectRatio: 1 / 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(
                                        width: 0.3,
                                        color: getCustomColors(context)
                                                .hardBorder ??
                                            Colors.transparent,
                                        // strokeAlign: BorderSide.strokeAlignOutside,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: kElevationToShadow[3],
                                    ),
                                    // padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                  "assets/details_illustartions/contact_1_cut.png"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              "Contact",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(-1, -0.5),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "Add Contact Information to get Tabo home faster",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.28),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(
                                                    flex: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Transform.scale(
                                                scale: 1.7,
                                                alignment: Alignment.bottomLeft,
                                                child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                          useMaterial3: true),
                                                  child: Switch(
                                                    value: true,
                                                    activeColor:
                                                        getCustomColors(context)
                                                            .accentDark,
                                                    inactiveTrackColor:
                                                        getCustomColors(context)
                                                            .lightBorder,
                                                    onChanged: (bool value) {
                                                      // setState(() {
                                                      //   _value = value;
                                                      // });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              openBuilder: (context, action) => ContactPage(
                                // petProfileDetails: widget.getProfileDetails(),
                                petProfileDetails: widget.petProfileDetails,
                                showBottomNavBar: (show) {
                                  // if (mounted && show != _showBottomNavBar) {
                                  //   setState(() {
                                  //     _showBottomNavBar = show;
                                  //   });
                                  // }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const GridSpacing(),
                      Expanded(
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    width: 0.5,
                                    color:
                                        getCustomColors(context).hardBorder ??
                                            Colors.transparent,
                                    // strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: kElevationToShadow[3],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          "assets/details_illustartions/gem_gold_1_cut.png",
                                          scale: 8,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Image.asset(
                                          "assets/details_illustartions/gem_jade_1_cut.png",
                                          scale: 9,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-1, -0.3),
                                        child: Image.asset(
                                          "assets/details_illustartions/heart_pink_1_cut.png",
                                          scale: 8,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            "Finma Tags",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(1, 0.6),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Spacer(
                                                flex: 5,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "Assign Finma Tags so Tabo is safe and stylish",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 16,
                                                    color: Colors.black
                                                        .withOpacity(0.28),
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const GridSpacing(),
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  color: Colors.yellow,
                                  border: Border.all(
                                    width: 0.3,
                                    color:
                                        getCustomColors(context).hardBorder ??
                                            Colors.transparent,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: kElevationToShadow[3],
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/details_illustartions/dog_picture_tmp.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(18),
                                        ),
                                        border: Border.all(
                                          width: 0.3,
                                          color: getCustomColors(context)
                                                  .hardBorder ??
                                              Colors.transparent,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        "Pictures",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const GridSpacing(),
                    ],
                  ),
                  const GridSpacing(),
                  Row(
                    children: [
                      const GridSpacing(),
                      Expanded(
                        child: OpenContainer(
                          closedBuilder: (context, action) => Transform(
                            alignment: FractionalOffset.center,
                            transform: perspective.scaled(1.0, 1.0, 1.0)
                              ..rotateX(_tiltAngle)
                              ..rotateY(0.0)
                              ..rotateZ(0.0),
                            child: AspectRatio(
                              aspectRatio: 2 / 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    width: 0.3,
                                    color:
                                        getCustomColors(context).hardBorder ??
                                            Colors.transparent,
                                    // strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: kElevationToShadow[3],
                                ),
                                // padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                              "assets/details_illustartions/basic_cat_1_cut.png"),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-0.5, 0.99),
                                      child: Image.asset(
                                        "assets/details_illustartions/basic_dog_1_cut.png",
                                        scale: 1.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        "Basic Information",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          openBuilder: (context, action) =>
                              BasicInformationPage(
                            petProfileDetails: _petProfileDetails,
                            setGender: (value) {
                              _petProfileDetails.petGender = value;
                              updatePetProfileCore(_petProfileDetails);
                            },
                          ),
                        ),
                      ),
                      const GridSpacing(),
                    ],
                  ),
                  const GridSpacing(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GridSpacing(),
                      Expanded(
                        child: Column(
                          children: [
                            OpenContainer(
                              closedBuilder: (context, action) => AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(
                                      width: 0.3,
                                      color:
                                          getCustomColors(context).hardBorder ??
                                              Colors.transparent,
                                      // strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: kElevationToShadow[3],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Stack(
                                      children: [
                                        // Align(
                                        //   alignment: Alignment.bottomRight,
                                        //   child: Image.asset(
                                        //     "assets/details_illustartions/description_dog_1_cut.png",
                                        //     scale: 1.6,
                                        //   ),
                                        // ),
                                        // Align(
                                        //   alignment: Alignment.bottomLeft,
                                        //   child: Image.asset(
                                        //     "assets/details_illustartions/description_cat_2_cut.png",
                                        //     scale: 1.9,
                                        //   ),
                                        // ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Image.asset(
                                            "assets/details_illustartions/description_dog_1.png",
                                            scale: 1.5,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              openBuilder: (context, action) => DescriptionPage(
                                descriptions: _petProfileDetails.petDescription,
                                petProfileId: _petProfileDetails.profileId,
                              ),
                            ),
                            const GridSpacing(),
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    width: 0.3,
                                    color:
                                        getCustomColors(context).hardBorder ??
                                            Colors.transparent,
                                    // strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: kElevationToShadow[3],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(-0.95, 0.99),
                                        child: Image.asset(
                                          "assets/details_illustartions/documents_cat_1_cut.png",
                                          scale: 1.4,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          "Documents",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const GridSpacing(),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1 / 2 - 8 / 100.w,
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: perspective.scaled(1.0, 1.0, 1.0)
                              ..rotateX(_tiltAngle)
                              ..rotateY(0.0)
                              ..rotateZ(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border: Border.all(
                                  width: 0.5,
                                  color: getCustomColors(context).hardBorder ??
                                      Colors.transparent,
                                  // strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: kElevationToShadow[3],
                              ),
                              // padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                            "assets/details_illustartions/medical_1_cut.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        "Medical",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(-1, -0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                "Add Medical Information to keep Tabo safe",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.28),
                                                ),
                                              ),
                                            ),
                                            Spacer(
                                              flex: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const GridSpacing(),
                    ],
                  ),
                  const GridSpacing(),
                  const GridSpacing(),
                  Text(
                    "Every change gets saved and uploaded automatically",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.36),
                    ),
                  ),
                  // const SizedBox(height: 90),
                  const GridSpacing(),
                  const GridSpacing(),
                ],
              ),
            ),
          ],
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

class GridSpacing extends StatelessWidget {
  const GridSpacing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 16, height: 16);
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