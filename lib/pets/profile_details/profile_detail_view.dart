import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/pages/contact_page.dart';
import 'package:userapp/pets/profile_details/pages/documents_page.dart';
import 'package:userapp/pets/profile_details/pages/images_page.dart';
import 'package:userapp/pets/profile_details/pages/profile_info_page.dart';
import 'package:userapp/pets/profile_details/pictures/upload_picture_dialog.dart';
import 'fabs/upload_document_fab.dart';
import 'fabs/upload_image_fab.dart';
import 'u_profile_details.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PetProfileDetailView extends StatefulWidget {
  const PetProfileDetailView({
    super.key,
    required this.petProfileDetails,
    required this.reloadFuture,
    required this.getProfileDetails,
  });

  final PetProfileDetails petProfileDetails;

  final VoidCallback reloadFuture;

  final PetProfileDetails Function() getProfileDetails;

  @override
  State<PetProfileDetailView> createState() => PetProfileDetailViewState();
}

class PetProfileDetailViewState extends State<PetProfileDetailView> {
  final PageController _pageController = PageController();
  double pageindex = 0;

  final List<ScrollController> _scrollControllers =
      List.filled(4, ScrollController());

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        pageindex = _pageController.page ?? 0;
      });
    });

    // if (widget.petProfileDetails.petName == null) {
    //   WidgetsBinding.instance.addPostFrameCallback(
    //     (_) {
    //       askForPetName(
    //           context,
    //           (value) => setState(() {
    //                 widget.petProfileDetails.petName = value;
    //               }),
    //           null);
    //     },
    //   );
    // }
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder();
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = const EdgeInsets.all(0);

  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          elevation: 16,

          ///configuration for SnakeNavigationBar.color
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: pageindex.round(),
          onTap: (value) {
            _pageController.jumpToPage(value);
            _scrollControllers.elementAt(value).animateTo(0,
                duration: const Duration(milliseconds: 125),
                curve: Curves.fastOutSlowIn);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.safety_check), label: 'microphone'),
          ],
        ),
        floatingActionButton: getFloatingActionButton(pageindex.round()),
        extendBodyBehindAppBar: false,
        extendBody: false,
        resizeToAvoidBottomInset: true,
        body: PageView(
          controller: _pageController,
          children: [
            ProfileDetailsImagePage(
              scrollController: _scrollControllers.elementAt(0),
              getProfileDetails: widget.getProfileDetails,
              removePetPicture: (index) async {
                await deletePicture(
                    widget.getProfileDetails().petPictures.elementAt(index));
                //TODO update UI
                //hekps against 403 from server
                widget.reloadFuture.call();
                Future.delayed(Duration(milliseconds: 100))
                    .then((value) => refresh());
              },
            ),
            ProfileInfoPage(
              scrollController: _scrollControllers.elementAt(1),
              petProfileDetails: widget.petProfileDetails,
            ),
            ContactPage(
              scrollController: _scrollControllers.elementAt(2),
              petProfileDetails: widget.petProfileDetails,
            ),
            DocumentsPage(
              scrollController: _scrollControllers.elementAt(3),
              petProfileDetails: widget.petProfileDetails,
            ),
          ],
        ),
      ),
    );
  }

  Widget? getFloatingActionButton(int index) {
    switch (index) {
      case 0:
        return UploadImageFab(
          addPetPicture: (value) async {
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
              widget.petProfileDetails.profileId!,
              value,
              () async {
                print("uplaoded");
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => refresh());
                Navigator.pop(dialogContext!);
              },
            );
          },
        );
      case 3:
        return UploadDocumentFab(
          addDocument: (value, filename, documentType, contentType) async {
            await uploadDocuments(
              widget.petProfileDetails.profileId!,
              value,
              filename,
              documentType,
              contentType,
              () {
                print("uplaoded");
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                Future.delayed(Duration(milliseconds: 850))
                    .then((value) => refresh());
              },
            );
          },
        );
      default:
        return null;
    }
  }
}

Widget getPage(
    int index, Widget page1, Widget page2, Widget page3, Widget page4) {
  switch (index) {
    case 0:
      return page1;
    case 1:
      return page2;
    case 2:
      return page3;
    case 3:
      return page4;
    default:
      return page1;
  }
}
