import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/models/m_tag_personalisation.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import '../pet_color/u_pet_colors.dart';
import '../styles/text_styles.dart';
import 'page_transform.dart';
import 'pet_profile_preview.dart';
import 'profile_details/models/m_tag.dart';

class MyPets extends StatefulWidget {
  const MyPets({
    super.key,
    required this.petProfiles,
    required this.setAppBarNotchColor,
  });

  final List<PetProfileDetails> petProfiles;
  final ValueSetter<Color> setAppBarNotchColor;

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final PageController _controller =
      PageController(viewportFraction: 0.8, keepPage: false);

  double pageindex = 0;
  late Color backgroundColor;

  List<GlobalKey<PetProfilePreviewState>> pageKeys =
      List<GlobalKey<PetProfilePreviewState>>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    for (var _ in widget.petProfiles) {
      pageKeys.add(GlobalKey<PetProfilePreviewState>());
    }

    _controller.addListener(() {
      setState(() {
        pageindex = _controller.page ?? 0;
        backgroundColor = getColor(widget.petProfiles, pageindex);
        _closeExtendedActions();
        print(pageindex);
      });
      widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex));
    });

    backgroundColor = getColor(widget.petProfiles, pageindex);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex)));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _closeExtendedActions() {
    if (pageKeys.elementAt(pageindex.round()).currentState != null) {
      pageKeys.elementAt(pageindex.round()).currentState?.closeExpendedAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Pets",
          style: homeScreenTitle,
        ),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProfileDetailView(
                        //ASK for Tag for Profile! No Profile without tag first
                        petProfileDetails:
                            PetProfileDetails.createNewEmptyProfile(
                          [
                            Tag(
                              "x",
                              999999,
                              "x",
                              "x",
                              TagPersonalisation(
                                99999,
                                "x",
                                "x",
                                "x",
                                "x",
                                "x",
                                "x",
                                HexColor("FCF7DE"),
                                HexColor("FCF7DE"),
                                HexColor("FCF7DE"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _closeExtendedActions();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: const Alignment(0, -0.5),
          // margin: const EdgeInsets.only(top: 16),
          child: SizedBox(
            height: 75.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  //? Only for web testin needed, not for app!
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return PetProfilePreviewPageTransform(
                          page: pageindex,
                          position: position,
                          maxRotation: 15,
                          minScaling: 0.9,
                          child: PetProfilePreview(
                            key: pageKeys.elementAt(position),
                            petProfileDetails:
                                widget.petProfiles.elementAt(position),
                            imageAlignmentOffset:
                                -getAlignmentOffset(pageindex, position),
                          ),
                        );
                      },
                      // itemCount: 4,
                      itemCount: widget.petProfiles.length,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: widget.petProfiles.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
