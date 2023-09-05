import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/single_picture.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/upload_pictures_button.dart';
import 'package:userapp/general/network_globals.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';
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

  // List<Widget> getPictureWidgets() {
  //   List<Widget> list = [];
  //   if (pictures.length > 2) {
  //     list.add(
  //       Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ConstrainedBox(
  //             constraints: BoxConstraints(
  //               minWidth: 100.w,
  //               maxHeight: 150.w,
  //             ),
  //             child: PictureItem(
  //               picture: pictures.elementAt(0),
  //             ),
  //           ),
  //           Row(
  //             children: [],
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   return list;
  // }

  List<Widget> addRestPictureWidgets(List<Widget> list, int startIndex) {
    // List<Widget> list = [];
    for (int index = startIndex; index < pictures.length; index++) {
      list.add(
        SizedBox(
          width: 50.w,
          child: AspectRatio(
            aspectRatio: 1,
            child: PictureItem(
              picture: pictures.elementAt(index),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NewWidget(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabos Pictures"),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                pageBuilder: (BuildContext context, _, __) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.06),
                        child: Center(
                          child: Hero(
                            tag: "preview",
                            child: Container(
                              width: 200,
                              height: 300,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: "preview",
            child: Container(
              width: 200,
              height: 300,
              color: Colors.green,
            ),
          ),
        ),
      ),
      // body: Stack(
      //   children: [
      //     GestureDetector(
      //       onTap: () {
      //         Navigator.of(context).push(
      //           PageRouteBuilder(
      //             opaque: false,
      //             barrierDismissible: true,
      //             pageBuilder: (BuildContext context, _, __) {
      //               return BackdropFilter(
      //                 filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                   },
      //                   child: Container(
      //                     width: double.infinity,
      //                     height: double.infinity,
      //                     color: Colors.black.withOpacity(0.06),
      //                     child: Center(
      //                       child: Hero(
      //                         tag: "preview",
      //                         child: Container(
      //                           width: 200,
      //                           height: 300,
      //                           color: Colors.green,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         );
      //       },
      //       child: Hero(
      //         tag: "preview",
      //         child: AspectRatio(
      //           aspectRatio: 1,
      //           child: Container(
      //             decoration: BoxDecoration(
      //               // color: Theme.of(context).primaryColor,
      //               color: Colors.yellow,
      //               border: Border.all(
      //                 width: 0.3,
      //                 color: getCustomColors(context).hardBorder ??
      //                     Colors.transparent,
      //                 strokeAlign: BorderSide.strokeAlignOutside,
      //               ),
      //               borderRadius: BorderRadius.circular(18),
      //               boxShadow: kElevationToShadow[3],
      //               image: DecorationImage(
      //                 image: AssetImage(
      //                     "assets/details_illustartions/dog_picture_tmp.png"),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.circular(18),
      //               child: Align(
      //                 alignment: Alignment.bottomLeft,
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     color: Theme.of(context).primaryColor,
      //                     borderRadius: const BorderRadius.only(
      //                       topRight: Radius.circular(18),
      //                     ),
      //                     border: Border.all(
      //                       width: 0.3,
      //                       color: getCustomColors(context).hardBorder ??
      //                           Colors.transparent,
      //                       strokeAlign: BorderSide.strokeAlignOutside,
      //                     ),
      //                   ),
      //                   padding: EdgeInsets.all(16),
      //                   child: Text(
      //                     "Pictures",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 24,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     // SingleChildScrollView(
      //     //   child: Wrap(
      //     //     children: addRestPictureWidgets([], 0),
      //     //   ),
      //     // ),
      //     UploadPictureButton(
      //       profileId: widget.petProfileId,
      //       showUploadButton: _showUploadButton,
      //       reloadPictures: reloadPetPictures,
      //     ),
      //   ],
      // ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, _, __) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.06),
                    child: Center(
                      child: Hero(
                        key: ValueKey("sd"),
                        tag: "previegdfsgfdsw",
                        child: Container(
                          width: 200,
                          height: 300,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Hero(
        key: ValueKey("sss"),
        tag: "previegdfsgfdsw",
        child: Container(
          width: 200,
          height: 300,
          color: Colors.green,
        ),
      ),
    );
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
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.06),
                    child: Center(
                      child: Hero(
                        tag: "preview",
                        child: Container(
                          width: 200,
                          height: 300,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      // child: Material(
      //   borderRadius: BorderRadius.circular(8),
      //   elevation: 4,
      //   child: Hero(
      //     tag: "preview",
      //     child: ClipRRect(
      //         borderRadius: BorderRadius.circular(8),
      //         child:
      //             SinglePicture(imageUrl: s3BaseUrl + picture.petPictureLink)),
      //   ),
      // ),
      child: Hero(
        tag: "preview",
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor,
              color: Colors.yellow,
              border: Border.all(
                width: 0.3,
                color:
                    getCustomColors(context).hardBorder ?? Colors.transparent,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: kElevationToShadow[3],
              image: DecorationImage(
                image: AssetImage(
                    "assets/details_illustartions/dog_picture_tmp.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(18),
                    ),
                    border: Border.all(
                      width: 0.3,
                      color: getCustomColors(context).hardBorder ??
                          Colors.transparent,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Pictures",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                   PageRouteBuilder(
//                                     opaque: false,
//                                     barrierDismissible: true,
//                                     pageBuilder: (BuildContext context, _, __) {
//                                       return BackdropFilter(
//                                         filter: ImageFilter.blur(
//                                             sigmaX: 2, sigmaY: 2),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Container(
//                                             width: double.infinity,
//                                             height: double.infinity,
//                                             color:
//                                                 Colors.black.withOpacity(0.06),
//                                             child: Center(
//                                               child: Hero(
//                                                 tag: "preview",
//                                                 child: Container(
//                                                   width: 200,
//                                                   height: 300,
//                                                   color: Colors.green,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Hero(
//                                 tag: "preview",
//                                 child: AspectRatio(
