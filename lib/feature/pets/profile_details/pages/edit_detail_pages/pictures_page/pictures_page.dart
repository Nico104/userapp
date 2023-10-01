import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/picture_expanded.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/picture_selection.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/single_picture.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

import '../../../../../../general/widgets/custom_scroll_view.dart';
import '../../../../u_pets.dart';
import '../../../models/m_pet_picture.dart';
import '../../../pictures/upload_picture_dialog.dart';
import '../../../u_profile_details.dart';
import '../../../../../../general/widgets/shy_button.dart';

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
  bool _showShyButton = true;

  @override
  void initState() {
    super.initState();
    pictures = widget.initialPetPictures;
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

  Widget getNoPicturesWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pictures"),
      ),
      body: Column(
        children: [
          Spacer(),
          Image.asset("assets/tmp/dog_bowl.png"),
          const SizedBox(height: 8),
          Text(
            "It looks quite empty in here",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "picturesPage_noPictures".tr(),
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ShyButton(
            showUploadButton: true,
            onTap: () {
              _uploadPicture();
            },
            label: "picturesPage_uploadPictureLabel".tr(),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (pictures.isNotEmpty) {
      return Scaffold(
        body: Stack(
          children: [
            CustomNicoScrollView(
              // onScroll: _handleNavBarShown,
              onScroll: () => handleShyButtonShown(
                setShowShyButton: (p0) {
                  setState(() {
                    _showShyButton = p0;
                  });
                },
              ),
              title: Text("picturesPage_Title".tr()),
              body: Column(
                children: [
                  GridView.builder(
                    itemCount: pictures.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getCrossAxisCount(pictures.length),
                      // crossAxisCount: 1,
                      childAspectRatio: 1,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PictureItem(picture: pictures.elementAt(index)),
                      );
                    },
                  ),
                  SizedBox(height: 90.h),
                ],
              ),
            ),
            ShyButton(
              label: "picturesPage_uploadPictureLabel".tr(),
              showUploadButton: _showShyButton,
              onTap: () => _uploadPicture(),
              icon: Icon(
                Icons.file_upload_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return getNoPicturesWidget();
    }
  }

  void _uploadPicture() {
    showCustomNicoModalBottomSheet(
      context: context,
      child: PictureSelection(
        addPicture: (value) async {
          //Loading Dialog Thingy
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
            widget.petProfileId,
            value,
            () async {
              print("uplaoded");
              // widget.reloadFuture.call();
              //TODO update UI
              //hekps against 403 from server
              await Future.delayed(const Duration(milliseconds: 2000)).then(
                (value) => reloadPetPictures(),
              );
              //Close Loading Dialog Thingy
              Navigator.pop(dialogContext!);
            },
          );
        },
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
