import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../network_globals.dart';
import '../../../styles/custom_icons_icons.dart';
import '../models/m_pet_picture.dart';
import '../pictures/c_pictures.dart';

class PictureList extends StatefulWidget {
  const PictureList({
    super.key,
    required this.petPictures,
    required this.removePetPicture,
    required this.scrollToImageposition,
  });

  final List<PetPicture> petPictures;
  final ValueSetter<int> removePetPicture;
  final int scrollToImageposition;

  @override
  State<PictureList> createState() => _PictureListState();
}

class _PictureListState extends State<PictureList> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scrollController.position.ensureVisible(
      //   key.currentContext!.findRenderObject()!,
      //   alignment:
      //       0.5, // How far into view the item should be scrolled (between 0 and 1).
      //   duration: const Duration(seconds: 1),
      // );
      itemScrollController.jumpTo(
          index: widget.scrollToImageposition, alignment: 0);
    });
  }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images"),
        scrolledUnderElevation: 8,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ScrollablePositionedList.builder(
          itemCount: widget.petPictures.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 38),
                SinglePicture(
                  removePetPicture: () {
                    widget.removePetPicture.call(index);
                  },
                  imageUrl: s3BaseUrl +
                      widget.petPictures.elementAt(index).petPictureLink,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        // Icons.share,
                        CustomIcons.share_thin,
                        size: 24,
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          scrollOffsetListener: scrollOffsetListener,
        ),
        // child: ListView.builder(
        //   //Lenght of petPictures + 1 for new Image
        //   itemCount: widget.petPictures.length,
        //   // shrinkWrap: true,
        //   controller: scrollController,
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index < widget.petPictures.length) {
        //       return Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           SinglePicture(
        //             //scroll To
        //             key: index == widget.scrollToImageposition ? key : null,
        //             removePetPicture: () {
        //               widget.removePetPicture.call(index);
        //             },
        //             imageUrl: s3BaseUrl +
        //                 widget.petPictures.elementAt(index).petPictureLink,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.fromLTRB(16, 16, 16, 38),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: const [
        //                 Icon(
        //                   // Icons.share,
        //                   CustomIcons.share_thin,
        //                   size: 24,
        //                 ),
        //                 // GestureDetector(
        //                 //   onTap: () {
        //                 //     // widget.removePetPicture.call();
        //                 //     Navigator.pop(context);
        //                 //   },
        //                 //   child: const Icon(
        //                 //     CustomIcons.delete,
        //                 //     size: 34,
        //                 //   ),
        //                 // ),
        //               ],
        //             ),
        //           )
        //         ],
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
