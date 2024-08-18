import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/network_globals.dart';

//TODO localization

void showHowToDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return const HowToDialog();
      }));
}

class HowToDialog extends StatefulWidget {
  const HowToDialog({Key? key}) : super(key: key);

  @override
  State<HowToDialog> createState() => _HowToDialogState();
}

class _HowToDialogState extends State<HowToDialog> {
  final PageController pageController = PageController();

  late double _currentPage;

  final int count = 7;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  bool isLastPage() {
    return _currentPage > count - 2;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.5),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.transparent],
                        stops: [0.9, 1],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: PageView(
                        controller: pageController,
                        children: [
                          HowToTab(
                            openBottom: false,
                            title: "tutorial_Title_Create_Pet".tr(),
                            description: "tutorial_Description_Create_Pet".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Create_Pet".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/tutorial_new_pet.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Tags_Pet".tr(),
                            description: "tutorial_Description_Tags_Pet".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Tags_Pet".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/pet_tags.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Tags_Account".tr(),
                            description:
                                "tutorial_Description_Tags_Account".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Tags_Account".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/account_tags.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Pet_Contacts".tr(),
                            description:
                                "tutorial_Description_Pet_Contacts".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Pet_Contacts",
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/pet_contacts.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Notifications".tr(),
                            description:
                                "tutorial_Description_Notifications".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Notifications".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/account_notifications.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Pet_Lost".tr(),
                            description: "tutorial_Description_Pet_Lost".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Pet_Lost".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/pet_lost.png",
                          ),
                          HowToTab(
                            title: "tutorial_Title_Pet_Privacy".tr(),
                            description:
                                "tutorial_Description_Pet_Privacy".tr(),
                            imageDescription:
                                "tutorial_imageDescription_Pet_Privacy".tr(),
                            imageUrl:
                                "${s3BaseUrl}utils/tutorial_pictures/pet_visibility.png",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // SizedBox(height: 32),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () {
                          if (!isLastPage()) {
                            pageController.nextPage(
                                duration: Durations.short3,
                                curve: Curves.fastOutSlowIn);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.black87,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: Text(
                            !isLastPage()
                                ? "tutorial_Next".tr()
                                : "tutorial_Done".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      // SizedBox(height: 42),
                      const Spacer(),
                      DotsIndicator(
                        dotsCount: count,
                        position: _currentPage,
                        decorator: DotsDecorator(
                          activeColor: Colors.black,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      // SizedBox(height: 38),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.black12,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(Icons.close_rounded),
                        ),
                      ),
                      // SizedBox(height: 48),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HowToTab extends StatelessWidget {
  const HowToTab({
    super.key,
    required this.title,
    required this.description,
    required this.imageDescription,
    required this.imageUrl,
    this.openBottom = true,
  });

  final String title;
  final String description;
  final String imageDescription;
  final String imageUrl;
  final bool openBottom;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 72),
          Text(
            imageDescription,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 4,
                child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        end: !openBottom
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        begin: !openBottom
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                        colors: [Colors.white, Colors.transparent],
                        stops: [0.98, 1],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: CachedNetworkImage(imageUrl: imageUrl)),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
