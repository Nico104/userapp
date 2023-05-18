import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../network_globals.dart';
import '../../../styles/custom_icons_icons.dart';
import '../../../utils/widgets/more_button.dart';
import '../d_confirm_delete.dart';
import '../models/m_pet_picture.dart';
import 'c_pictures.dart';

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

  // void _showPopupMenu() async {
  //   await showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(100, 100, 100, 100),
  //     items: [
  //       PopupMenuItem<String>(child: const Text('Doge'), value: 'Doge'),
  //       PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
  //     ],
  //     elevation: 8.0,
  //   );
  // }

  void _showPopupMenu({
    required Offset offset,
    required int pictureIndex,
  }) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: [
        PopupMenuItem(
          value: 'Delete',
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (_) => const ConfirmDeleteDialog(label: "Picture"),
              ).then((value) {
                if (value != null && value is bool) {
                  if (value == true) {
                    widget.removePetPicture(pictureIndex);
                    //Doesnt update since its a new page / Navigator.push (navugatePerSlide) in c_pictures
                    setState(() {
                      widget.petPictures.removeAt(pictureIndex);
                    });
                  }
                }
              });
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                CustomIcons.delete,
                color: Colors.black,
              ),
              Text("Delete"),
            ],
          ),
        ),
        // PopupMenuItem(
        //   child: const Text('Lion'),
        //   value: 'Lion',
        // ),
      ],
      elevation: 8.0,
    );
  }

  Widget _getMoreButton(int pictureIndex) {
    return MoreButton(
      moreOptions: [
        ListTile(
          leading: const Icon(CustomIcons.delete),
          title: const Text("Delete Picture"),
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const ConfirmDeleteDialog(
                label: "Picture",
              ),
            ).then((value) {
              if (value != null) {
                if (value == true) {
                  widget.removePetPicture(pictureIndex);
                  //Doesnt update since its a new page / Navigator.push (navugatePerSlide) in c_pictures
                  setState(() {
                    widget.petPictures.removeAt(pictureIndex);
                  });
                }
              }
            });
          },
        ),
      ],
    );
  }

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
                  // removePetPicture: () {
                  //   widget.removePetPicture.call(index);
                  // },
                  imageUrl: s3BaseUrl +
                      widget.petPictures.elementAt(index).petPictureLink,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        CustomIcons.share_thin,
                        size: 24,
                      ),
                      _getMoreButton(index),
                      // GestureDetector(
                      //   onTapDown: (TapDownDetails details) {
                      //     _showPopupMenu(
                      //       offset: details.globalPosition,
                      //       pictureIndex: index,
                      //     );
                      //   },
                      //   child: const Icon(
                      //     Icons.more_horiz,
                      //     size: 24,
                      //   ),
                      // ),
                      // PopupMenuButton(
                      //   // onSelected: (value) {
                      //   //   _onMenuItemSelected(value as int);
                      //   // },
                      //   // offset: Offset(0.0, appBarHeight),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //       bottomLeft: Radius.circular(8.0),
                      //       bottomRight: Radius.circular(8.0),
                      //       topLeft: Radius.circular(8.0),
                      //       topRight: Radius.circular(8.0),
                      //     ),
                      //   ),
                      //   child: const Icon(
                      //     Icons.more_horiz,
                      //     size: 24,
                      //   ),
                      //   itemBuilder: (ctx) => [
                      //     _buildPopupMenuItem('Search', Icons.search, 0),
                      //     _buildPopupMenuItem('Upload', Icons.upload, 1),
                      //     _buildPopupMenuItem('Copy', Icons.copy, 2),
                      //     _buildPopupMenuItem('Exit', Icons.exit_to_app, 3),
                      //   ],
                      // )
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
      ),
    );
  }
}



// PopupMenuItem _buildPopupMenuItem(
//     String title, IconData iconData, int position) {
//   return PopupMenuItem(
//     value: position,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Icon(
//           iconData,
//           color: Colors.black,
//         ),
//         Text(title),
//       ],
//     ),
//   );
// }
