import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/feature/settings/setting_screens/theme_settings/system_theme_widget.dart';
import 'package:userapp/feature/settings/setting_screens/theme_settings/theme_item.dart';

import '../../../../general/utils_theme/store_manager.dart';
import '../../../../general/utils_theme/theme_provider.dart';
import '../../../pets/profile_details/models/m_pet_profile.dart';

class ThemeSelectionPage extends StatefulWidget {
  const ThemeSelectionPage({
    super.key,
    required this.theme,
    required this.petProfileDetails,
  });

  final ThemeNotifier theme;
  final PetProfileDetails petProfileDetails;

  @override
  State<ThemeSelectionPage> createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  final PageController _pageController = PageController(viewportFraction: 1);

  Map<int, ThemeSelectionContainer> map = {};
  int darkTheme = 0;
  int lightTheme = 1;

  bool isSystemActive = false;

  late ThemeNotifier theme;

  @override
  void initState() {
    super.initState();

    theme = widget.theme;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await StorageManager.readData('themeMode').then(
        (value) {
          if (value == 'system') {
            setState(() {
              isSystemActive = true;
            });
          }
        },
      );
    });

    generateMap();
  }

  void generateMap() {
    map.clear();
    // print(theme.getTheme().brightness);
    if (theme.getTheme() == theme.lightTheme) {
      darkTheme = 1;
      lightTheme = 0;
    }
    map[darkTheme] = ThemeSelectionContainer(
      isActive: theme.getTheme() == theme.darkTheme,
      onTap: () {
        if (theme.getTheme() != theme.darkTheme) {
          theme.setDarkTheme();
        }
      },
      label: "darkModeLabel".tr(),
      themeData: theme.darkTheme,
      petProfileDetails: widget.petProfileDetails,
    );
    map[lightTheme] = ThemeSelectionContainer(
      isActive: theme.getTheme() == theme.lightTheme,
      onTap: () {
        if (theme.getTheme() != theme.lightTheme) {
          theme.setLightTheme();
        }
      },
      label: "lightModeLabel".tr(),
      themeData: theme.lightTheme,
      petProfileDetails: widget.petProfileDetails,
    );
    var mapEntries = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    map
      ..clear()
      ..addEntries(mapEntries);

    if (mounted) {
      setState(() {});
    }
  }

  void refreshThemeData() {
    // print(Provider.of<ThemeNotifier>(context).getTheme());
    // setState(() {
    //   theme = Provider.of<ThemeNotifier>(context).getTheme();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarTitleThemeSettings".tr()),
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                pageSnapping: true,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  if (index == darkTheme) {
                    if (theme.getTheme() != theme.darkTheme) {
                      theme.setDarkTheme();
                    }
                  } else if (index == lightTheme) {
                    if (theme.getTheme() != theme.lightTheme) {
                      theme.setLightTheme();
                    }
                  }
                },
                children: map.values.toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChooseSystemTheme(
              isActive: isSystemActive,
              setSystemThemeActivity: (p0) {
                setState(() {
                  isSystemActive = p0;
                });
                if (p0) {
                  theme.setSystemTheme();
                  // refreshThemeData();
                  // map.clear();
                  generateMap();
                  _pageController.jumpToPage(0);
                } else {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    theme.setDarkTheme();
                    // refreshThemeData();
                    // map.clear();
                    generateMap();
                    _pageController.jumpToPage(0);
                  } else {
                    theme.setLightTheme();
                    // refreshThemeData();
                    // map.clear();
                    generateMap();
                    _pageController.jumpToPage(0);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
