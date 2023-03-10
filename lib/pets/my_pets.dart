import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/language/m_language.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/pets/profile_details/g_profile_detail_globals.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/models/m_tag_personalisation.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'package:userapp/pets/tag/tags.dart';
import 'package:userapp/pets/u_pets.dart';
import '../pet_color/u_pet_colors.dart';
import '../styles/text_styles.dart';
import 'page_transform.dart';
import 'pet_profile_preview.dart';
import 'profile_details/models/m_tag.dart';
import 'tag/tag_selection/d_tag_selection.dart';

class MyPets extends StatefulWidget {
  const MyPets({
    super.key,
    required this.petProfiles,
    required this.setAppBarNotchColor,
    required this.availableLanguages,
    required this.reloadFuture,
  });

  final List<PetProfileDetails> petProfiles;
  final ValueSetter<Color> setAppBarNotchColor;

  final List<Language> availableLanguages;

  final VoidCallback reloadFuture;

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
  );

  double pageindex = 0;
  late Color backgroundColor;

  late List<GlobalKey<PetProfilePreviewState>> pageKeys;

  @override
  void initState() {
    super.initState();
    //InitAvailableLanguages
    availableLanguages = List.from(widget.availableLanguages);

    initKey();

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
  void didUpdateWidget(covariant MyPets oldWidget) {
    super.didUpdateWidget(oldWidget);
    availableLanguages = List.from(widget.availableLanguages);
    initKey();
  }

  void initKey() {
    pageKeys = List<GlobalKey<PetProfilePreviewState>>.empty(growable: true);
    for (var _ in widget.petProfiles) {
      pageKeys.add(GlobalKey<PetProfilePreviewState>());
    }
    setState(() {});
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const TagSelectionDialog(
                    currentTags: [],
                  ),
                ).then((value) {
                  if (value is List<Tag>) {
                    if (value.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetProfileDetailView(
                            petProfileDetails:
                                PetProfileDetails.createNewEmptyProfile(
                              value,
                            ),
                            reloadFuture: () => widget.reloadFuture.call(),
                          ),
                        ),
                      );
                    }
                  }
                });
              },
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
                            // imageAlignmentOffset: 0,
                            reloadFuture: () => widget.reloadFuture.call(),
                          ),
                        );
                      },
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
