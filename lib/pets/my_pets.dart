import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import '../pet_color/u_pet_colors.dart';
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
      PageController(viewportFraction: 0.8, keepPage: true);

  double pageindex = 0;

  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        pageindex = _controller.page ?? 0;
        backgroundColor = getColor(widget.petProfiles, pageindex);
        print(pageindex);
      });
      widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex));
    });

    backgroundColor = getColor(widget.petProfiles, pageindex);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex)));
  }

  // void initBackgroundColor(List<PetProfileDetails> list, double pageindex) {
  //   //pageindex should be 0
  //   setState(() {
  //     backgroundColor = getColor(widget.petProfiles, pageindex);
  //   });
  //   widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex));
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Pets"),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProfileDetailView(
                        petProfileDetails:
                            PetProfileDetails.createNewEmptyProfile(
                          List<Tag>.empty(growable: false),
                        ),
                      ),
                    ),
                  ),
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: SizedBox(
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
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
                          // petProfileDetails:
                          //     PetProfileDetails.createNewEmptyProfile(
                          //         []),
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
    );
  }
}
