import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/pets.dart';

import 'bottom_nav_bar/chip_style.dart';
import 'bottom_nav_bar/src/bottom_bar_inspired_inside.dart';
import 'bottom_nav_bar/tab_item.dart';
import 'bottom_nav_bar/widgets/inspired/inspired.dart';
import 'pet_color/u_pet_colors.dart';
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
  int visit = 1;

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
        chipStyle: ChipStyle(
          convexBridge: true,
          background:
              getBackgroundColorFromTagColor(getTagColorFromString("Yellow")),
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
