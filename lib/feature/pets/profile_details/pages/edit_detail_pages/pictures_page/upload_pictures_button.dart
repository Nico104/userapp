import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../pictures/upload_picture_dialog.dart';
import '../../../u_profile_details.dart';
import 'picture_selection.dart';

class UploadPictureButton extends StatelessWidget {
  const UploadPictureButton({
    super.key,
    required bool showUploadButton,
    required this.profileId,
    required this.reloadPictures,
  }) : _showUploadButton = showUploadButton;

  final bool _showUploadButton;
  final int profileId;

  final double _borderRadius = 32;

  // final Future<void> Function(Uint8List) addPetPicture;
  final VoidCallback reloadPictures;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedAlign(
        alignment: _showUploadButton
            ? const Alignment(0.0, 1.0)
            : const Alignment(0.0, 3.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            elevation: 8,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
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
                            profileId,
                            value,
                            () async {
                              print("uplaoded");
                              // widget.reloadFuture.call();
                              //TODO update UI
                              //hekps against 403 from server
                              await Future.delayed(
                                      const Duration(milliseconds: 2000))
                                  .then((value) => reloadPictures);
                              //Close Loading Dialog Thingy
                              Navigator.pop(dialogContext!);
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  // color: Colors.blue,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Upload Picture",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
