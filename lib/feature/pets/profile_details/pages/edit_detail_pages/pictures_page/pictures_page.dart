import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/picture_expanded.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/single_picture.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/upload_pictures_button.dart';
import 'package:userapp/general/network_globals.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../general/widgets/custom_scroll_view.dart';
import '../../../../u_pets.dart';
import '../../../models/m_pet_picture.dart';
import '../../../pictures/upload_picture_dialog.dart';
import '../../../u_profile_details.dart';

class PicturesPage extends StatefulWidget {
  const PicturesPage(
      {super.key,
      required this.initialPetPictures,
      required this.petProfileId});

  final List<PetPicture> initialPetPictures;
  final int petProfileId;

  @override
  State<PicturesPage> createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  late List<PetPicture> pictures;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pictures = widget.initialPetPictures;
    _scrollController.addListener(() {
      _handleNavBarShown();
    });
  }

  //TODO getDocuments
  Future<void> reloadPetPictures() async {
    pictures = await getPetPictures(widget.petProfileId);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant PicturesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Needed since docuemnts dont get accessed directly so updating it has effect
    pictures = widget.initialPetPictures;
  }

  bool _showUploadButton = true;

  void _handleNavBarShown() {
    //hideBar
    setState(() {
      _showUploadButton = false;
    });
    EasyDebounce.debounce(
      'handleUploadPictureBarShown',
      const Duration(milliseconds: 250),
      () {
        //shwoNavbar
        setState(() {
          _showUploadButton = true;
        });
      },
    );
  }

  Widget getNoPicturesWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 120,
        ),
        SizedBox(
          width: 30.w,
          child: Image.asset("assets/tmp/documents.png"),
        ),
        const SizedBox(height: 32),
        Text(
          "No Pictures yet",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 32),
        UploadPictureButton(
          profileId: widget.petProfileId,
          showUploadButton: _showUploadButton,
          reloadPictures: reloadPetPictures,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            onScroll: _handleNavBarShown,
            title: Text("Tabos Pictures"),
            body: Column(
              children: [
                pictures.isNotEmpty
                    ? GridView.builder(
                        itemCount: pictures.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: getCrossAxisCount(pictures.length),
                          // crossAxisCount: 1,
                          childAspectRatio: 1,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                PictureItem(picture: pictures.elementAt(index)),
                          );
                        },
                      )
                    : getNoPicturesWidget(),
                SizedBox(height: 90.h),
              ],
            ),
          ),
          UploadPictureButton(
            profileId: widget.petProfileId,
            showUploadButton: _showUploadButton,
            reloadPictures: reloadPetPictures,
          ),
        ],
      ),
    );
  }
}

int getCrossAxisCount(int lenght) {
  if (lenght < 2) {
    return 1;
  } else if (lenght < 4) {
    return 2;
  } else {
    return 3;
  }
}

class PictureItem extends StatelessWidget {
  const PictureItem({
    super.key,
    required this.picture,
  });

  final PetPicture picture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, _, __) {
              return PetPictureExpanded(
                picture: picture,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: "picture${picture.petPictureId}",
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 4,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  SinglePicture(imageUrl: s3BaseUrl + picture.petPictureLink)),
        ),
      ),
    );
  }
}
