import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'package:userapp/pets/tag/tags.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'package:userapp/theme/custom_colors.dart';
import 'package:userapp/theme/custom_text_styles.dart';
import 'package:userapp/utils/util_methods.dart';
import 'pet_profile_preview_extended_actions.dart';
import 'profile_details/models/m_pet_profile.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({
    super.key,
    required this.petProfileDetails,
    required this.imageAlignmentOffset,
    required this.reloadFuture,
    required this.extendedActions,
    required this.switchExtendedActions,
  });

  final PetProfileDetails petProfileDetails;
  final double imageAlignmentOffset;
  final VoidCallback reloadFuture;
  final bool extendedActions;
  final VoidCallback switchExtendedActions;

  @override
  State<PetProfilePreview> createState() => PetProfilePreviewState();
}

class PetProfilePreviewState extends State<PetProfilePreview> {
  double collardimension = 130;
  double collaroffset = 10;
  double marginhorizontal = 03.w;
  final double borderRadius = 36;

  //Extended Actions
  final Duration _duration = const Duration(milliseconds: 125);
  final Curve _curve = Curves.fastOutSlowIn;
  final double topOffset = 25;
  final double bottomOffset = 16;
  final int iconFlex = 10;
  final int labelFlex = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  widget.switchExtendedActions();
                },
                child: AnimatedContainer(
                  duration: _duration,
                  curve: _curve,
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: widget.extendedActions ? 0 : topOffset,
                    left: widget.extendedActions ? 0 : marginhorizontal,
                    right: widget.extendedActions ? 0 : marginhorizontal,
                    //6 because its the shadow offset
                    bottom: widget.extendedActions
                        ? 16
                        : collardimension / 2 + collaroffset + bottomOffset,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            boxShadow: kElevationToShadow[4],
                            image: DecorationImage(
                              image: const NetworkImage(
                                  "https://picsum.photos/600/800"),
                              fit: BoxFit.cover,
                              alignment:
                                  Alignment(widget.imageAlignmentOffset, 0),
                            ),
                          ),
                          child: IgnorePointer(
                            ignoring: !widget.extendedActions,
                            child: ExtendedSettingsContainer(
                              isActive: widget.extendedActions,
                              petProfileDetails: widget.petProfileDetails,
                              reloadFuture: widget.reloadFuture,
                            ),
                          ),
                          // child: ExtendedSettingsContainer(
                          //     widget: widget,
                          //     widget: widget,
                          //     borderRadius: borderRadius,
                          //     widget: widget,
                          //     duration: _duration,
                          //     curve: _curve,
                          //     widget: widget,
                          //     iconFlex: iconFlex,
                          //     labelFlex: labelFlex,
                          //     widget: widget,
                          //     widget: widget),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       ClipRRect(
              //         child: Container(
              //           width: 50,
              //           height: 50,
              //           margin: const EdgeInsets.all(4),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(80),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black.withOpacity(0.16),
              //                 blurRadius: 6,
              //                 offset: const Offset(1, 3),
              //               ),
              //             ],
              //           ),
              //           // child: BackdropFilter(
              //           //   filter: ImageFilter.blur(
              //           //     sigmaX: 5,
              //           //     sigmaY: 5,
              //           //   ),
              //           //   child: const SizedBox.expand(),
              //           // ),
              //         ),
              //       ),
              //       const Icon(CustomIcons.edit),
              //     ],
              //   ),
              // ),
              IgnorePointer(
                // ignoring: widget.extendedActions,
                ignoring: true,
                child: GestureDetector(
                  // onTap: () {
                  //   showDialog(
                  //     context: context,
                  //     builder: (_) => TagSelectionDialog(
                  //       currentTags: widget.petProfileDetails.tag,
                  //     ),
                  //   ).then((value) async {
                  //     if (value != null) {
                  //       if (value is List<Tag> &&
                  //           widget.petProfileDetails.profileId != null) {
                  //         await handleTagChange(
                  //             value,
                  //             widget.petProfileDetails.tag,
                  //             widget.petProfileDetails.profileId!);
                  //         widget.reloadFuture.call();
                  //       }
                  //     }
                  //   });
                  // },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomOffset),
                    child: AnimatedOpacity(
                      duration: _duration,
                      curve: _curve,
                      opacity: widget.extendedActions ? 0 : 1,
                      child: Hero(
                        tag: 'collar${widget.petProfileDetails.profileId}',
                        child: Align(
                          // alignment: Alignment.bottomCenter,
                          alignment:
                              Alignment(widget.imageAlignmentOffset * -0.2, 1),
                          child: Tags(
                              tag: widget.petProfileDetails.tag,
                              collardimension: collardimension),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        AnimatedSize(
          duration: const Duration(milliseconds: 125),
          curve: Curves.fastOutSlowIn,
          child: SizedBox(
            width: widget.extendedActions ? 0 : null,
            height: widget.extendedActions ? 0 : null,
            child: Text(
              widget.petProfileDetails.petName ?? "",
              key: ValueKey<String>(widget.petProfileDetails.petName ?? ""),
              style: getCustomTextStyles(context).homePetName,
            ),
          ),
        ),
      ],
    );
  }
}

// class ExtendedSettingsContainer extends StatelessWidget {
//   const ExtendedSettingsContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: widget.extendedActions ? 130 : 0,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: widget.extendedActions
//                   ? const Radius.circular(0)
//                   : Radius.circular(borderRadius),
//               topRight: widget.extendedActions
//                   ? const Radius.circular(0)
//                   : Radius.circular(borderRadius),
//               bottomLeft: Radius.circular(borderRadius),
//               bottomRight: Radius.circular(borderRadius)),
//           color: Theme.of(context).primaryColor,
//         ),
//         child: AnimatedOpacity(
//           duration: _duration,
//           curve: _curve,
//           opacity: widget.extendedActions ? 1 : 0,
//           child: Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     //To trigger the Hit Box
//                     color: Colors.transparent,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           flex: iconFlex,
//                           child: const Center(
//                             child: Icon(
//                               CustomIcons.share_thin,
//                               // Icons.share_rounded,
//                               size: 32,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "Share",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                         Expanded(
//                           flex: labelFlex,
//                           child: const SizedBox(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     navigatePerSlide(
//                       context,
//                       PetProfileDetailView(
//                         petProfileDetails: widget.petProfileDetails,
//                         reloadFuture: widget.reloadFuture,
//                       ),
//                     );
//                   },
//                   // onTap: () => Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) =>
//                   //         PetProfileDetailView(
//                   //       petProfileDetails:
//                   //           widget.petProfileDetails,
//                   //       reloadFuture: widget.reloadFuture,
//                   //     ),
//                   //   ),
//                   // ),
//                   child: Container(
//                     //To trigger the Hit Box
//                     color: Colors.transparent,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           flex: iconFlex,
//                           child: const Center(
//                             child: Icon(
//                               CustomIcons.edit_square,
//                               size: 32,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "Edit",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                         Expanded(flex: labelFlex, child: const SizedBox()),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     //To trigger the Hit Box
//                     color: Colors.transparent,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           flex: iconFlex,
//                           child: const Center(
//                             child: Icon(
//                               CustomIcons.qr_code_9,
//                               size: 32,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "Scans",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                         Expanded(flex: labelFlex, child: const SizedBox()),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
