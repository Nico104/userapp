import 'package:flutter/material.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'bottom_nav_bar/chip_style.dart';
import 'bottom_nav_bar/src/bottom_bar_inspired_inside.dart';
import 'bottom_nav_bar/tab_item.dart';
import 'bottom_nav_bar/widgets/inspired/inspired.dart';
import 'pets/custom_paint_test.dart';
import 'pets/pets_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int visit = 1;

  double navbarheight = 60;
  double navbarbottompadding = 20;

  late PageController pageController;

  Color appBarNotchColor = Colors.white;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: visit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarInspiredInside(
        // height: 50,
        items: items,
        backgroundColor: Colors.white,
        color: Colors.black,
        colorSelected: Colors.black,
        indexSelected: visit,
        iconSize: 32,
        activeIconSize: 42,
        sizeInside: 64,
        notchBorderColor: Colors.black,
        notchBorderWidth: 1.5,
        notchTopMargin: 16,
        borderColor: Colors.black,
        // borderColor: Colors.white,
        borderWidth: 3,
        elevation: 0,
        curveSize: 82,
        onTap: (int index) {
          setState(() {
            visit = index;
          });
          pageController.jumpToPage(index);
        },
        chipStyle: ChipStyle(
          convexBridge: true,
          background: appBarNotchColor.withOpacity(0.45),
          notchSmoothness: NotchSmoothness.sharpEdge,
        ),
        itemStyle: ItemStyle.circle,
        animated: true,
        duration: const Duration(milliseconds: 75),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // onPageChanged: (v) {
        //   tabIndex = v;
        // },
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red),
          PetsLoading(
            setAppBarNotchColor: (value) {
              setState(() {
                appBarNotchColor = value;
              });
            },
          ),
          // Pets(bottomoffset: 0),
          Container(
            width: 300,
            height: 500,
            color: Colors.blue,
            child: Center(
              child: CustomPath(),
            ),
          ),
        ],
      ),
    );
  }
}

List<TabItem> items = [
  const TabItem(
    icon: CustomIcons.bag_2,
    // title: 'Shop',
  ),
  const TabItem(
    icon: CustomIcons.home,
    // title: 'Home',
  ),
  const TabItem(
    icon: CustomIcons.setting,
    // title: 'Setting',
  ),
];
