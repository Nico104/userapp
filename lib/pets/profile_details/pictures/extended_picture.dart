import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

class ExtendedPicture extends StatefulWidget {
  const ExtendedPicture({super.key, required this.image});

  final ImageProvider<Object> image;

  @override
  State<ExtendedPicture> createState() => _ExtendedPictureState();
}

class _ExtendedPictureState extends State<ExtendedPicture> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // alignment: const Alignment(0, 0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 16,
      child: SizedBox(
        width: 80.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: Image(image: widget.image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    // Icons.share,
                    CustomIcons.share_thin,
                    size: 34,
                  ),
                  Icon(
                    CustomIcons.delete,
                    size: 34,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
