import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/pets.dart';

import 'bottom_nav_bar/chip_style.dart';
import 'bottom_nav_bar/src/bottom_bar_inspired_inside.dart';
import 'bottom_nav_bar/tab_item.dart';
import 'bottom_nav_bar/widgets/inspired/inspired.dart';
import 'pets/custom_paint_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: "ss",
        ),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // int tabIndex = 1;
  // int _tabIndex = 1;
  // int get tabIndex => _tabIndex;
  // set tabIndex(int v) {
  //   _tabIndex = v;
  //   setState(() {});
  // }

  int visit = 0;

  double navbarheight = 60;
  double navbarbottompadding = 20;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: visit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      // bottomNavigationBar: CircleNavBar(
      //   activeIcons: const [
      //     Icon(Icons.person, color: Colors.black),
      //     Icon(Icons.home, color: Colors.black),
      //     Icon(Icons.favorite, color: Colors.black),
      //   ],
      //   inactiveIcons: const [
      //     Text("My"),
      //     Text("Home"),
      //     Text("Like"),
      //   ],
      //   iconCurve: Curves.fastOutSlowIn,
      //   iconDurationMillSec: 250,
      //   tabDurationMillSec: 250,
      //   color: Colors.white,
      //   height: 60,
      //   circleWidth: 60,
      //   activeIndex: tabIndex,
      //   onTap: (index) {
      //     tabIndex = index;
      //     pageController.jumpToPage(tabIndex);
      //   },
      //   padding:
      //       EdgeInsets.only(left: 16, right: 16, bottom: navbarbottompadding),
      //   cornerRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(8),
      //     topRight: Radius.circular(8),
      //     bottomRight: Radius.circular(24),
      //     bottomLeft: Radius.circular(24),
      //   ),
      //   shadowColor: Colors.black12,
      //   elevation: 8,
      // ),
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
        notchBorderWidth: 2.5,
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
        chipStyle: const ChipStyle(
          convexBridge: true,
          background: Colors.yellow,
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
          Pets(bottomoffset: (navbarheight + navbarbottompadding) * 1.2),
          // Container(
          //     width: double.infinity,
          //     height: double.infinity,
          //     color: Colors.blue),
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

const List<TabItem> items = [
  TabItem(
    icon: Icons.shopping_bag_outlined,
    // title: 'Shop',
  ),
  TabItem(
    icon: Icons.home_outlined,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.settings_outlined,
    // title: 'Setting',
  ),
];
