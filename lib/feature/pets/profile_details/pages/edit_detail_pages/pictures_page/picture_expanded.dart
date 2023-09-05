import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_picture.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/pictures_page/single_picture.dart';

import '../../../../../../general/network_globals.dart';
import '../../../../../../general/utils_custom_icons/custom_icons_icons.dart';

class PetPictureExpanded extends StatelessWidget {
  const PetPictureExpanded({super.key, required this.picture});

  final PetPicture picture;

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
              tag: "picture${picture.petPictureId}",
              child: Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 80.w,
                        minWidth: 40.w,
                        maxHeight: 50.h,
                        minHeight: 20.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Image.network(
                              s3BaseUrl + picture.petPictureLink,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  // Icons.share,
                                  CustomIcons.share_thin,
                                  size: 34,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // widget.removePetPicture.call();
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    CustomIcons.delete,
                                    size: 34,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
