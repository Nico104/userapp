import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../styles/text_styles.dart';

///Lets USer choose between camera and gallery
///returns 1 if Camera has been chosen or 0 if Gallery has been chosen
class GalleryCameraDialog extends StatefulWidget {
  const GalleryCameraDialog({
    super.key,
  });

  @override
  State<GalleryCameraDialog> createState() => _GalleryCameraDialogState();
}

class _GalleryCameraDialogState extends State<GalleryCameraDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Colors.black, width: 2.5),
      ),
      elevation: 0,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Picture with",
                style: pickerDialogTitleStyle,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.browse_gallery),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.camera),
                        Text("Camera"),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
