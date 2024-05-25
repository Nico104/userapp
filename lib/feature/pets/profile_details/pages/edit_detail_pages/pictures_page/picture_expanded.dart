import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_picture.dart';

import '../../../../../../general/network_globals.dart';
import '../../../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../../../general/widgets/custom_nico_modal.dart';
import '../../../d_confirm_delete.dart';
import '../../../u_profile_details.dart';

class PetPictureExpanded extends StatefulWidget {
  const PetPictureExpanded({super.key, required this.picture});

  final PetPicture picture;

  @override
  State<PetPictureExpanded> createState() => _PetPictureExpandedState();
}

class _PetPictureExpandedState extends State<PetPictureExpanded> {
  void showMoreOpton() {
    showCustomNicoModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text("picture_Options_Label_Share").tr(),
            onTap: () async {
              Navigator.pop(context);
              http.Response response = await http.get(
                Uri.parse(s3BaseUrl + widget.picture.petPictureLink),
              );
              onShareXFileFromAssets(response.bodyBytes);
              // readNotification(
              //   noticicationId: widget.notification.notificationId,
              // ).then((value) => widget.reload());
            },
          ),
          ListTile(
            leading: const Icon(CustomIcons.delete),
            title: const Text("picture_Options_Label_Delete").tr(),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => ConfirmDeleteDialog(
                  label: "deletePictureDialogLabel".tr(),
                ),
              ).then((value) {
                if (value != null) {
                  if (value == true) {
                    deletePicture(widget.picture).then(
                      (value) => Navigator.pop(context, true),
                    );
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void onShareXFileFromAssets(Uint8List image) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final data = await rootBundle.load('assets/flutter_logo.png');
    // final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          // buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          image,
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    // scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  @override
  Widget build(BuildContext context) {
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
              tag: "picture${widget.picture.petPictureId}",
              child: Material(
                borderRadius: BorderRadius.circular(22),
                elevation: 8,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 80.w,
                    minWidth: 5.w,
                    maxHeight: 50.h,
                    minHeight: 5.h,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          s3BaseUrl + widget.picture.petPictureLink,
                          // 'fit: BoxFit.contain,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showMoreOpton();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.more_vert),
                        ),
                      ),
                    ],
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

              // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     const Icon(
                        //       // Icons.share,
                        //       CustomIcons.share_thin,
                        //       size: 34,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         // widget.removePetPicture.call();
                        //         Navigator.pop(context);
                        //       },
                        //       child: Icon(
                        //         CustomIcons.delete,
                        //         size: 34,
                        //       ),
                        //     ),
                        //   ],
                        // )