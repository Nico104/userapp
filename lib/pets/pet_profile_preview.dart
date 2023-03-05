import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'package:userapp/pets/tag/tags.dart';
import '../pet_color/pet_colors.dart';
import '../styles/text_styles.dart';
import 'profile_details/models/m_pet_profile.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({
    super.key,
    required this.petProfileDetails,
    required this.imageAlignmentOffset,
  });

  final PetProfileDetails petProfileDetails;
  final double imageAlignmentOffset;

  @override
  State<PetProfilePreview> createState() => PetProfilePreviewState();
}

class PetProfilePreviewState extends State<PetProfilePreview> {
  double collardimension = 130;
  double collaroffset = 10;
  double marginhorizontal = 06.w;
  final double borderRadius = 14;

  //Extended Actions
  bool _showExtendedActions = false;
  final Duration _duration = const Duration(milliseconds: 125);
  final Curve _curve = Curves.fastOutSlowIn;
  final double topOffset = 28;

  void closeExpendedAction() {
    print("close actions");
    if (_showExtendedActions) {
      if (mounted) {
        setState(() {
          _showExtendedActions = false;
        });
      }
    }
  }

  //Extended Actions variables
  bool _switchValue = false;
  final int iconFlex = 10;
  final int labelFlex = 2;

  void switchLostValue() {
    setState(() {
      _switchValue = !_switchValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfileDetailView(
                petProfileDetails: widget.petProfileDetails,
              ),
            ),
          ),
          onLongPress: () {
            setState(() {
              _showExtendedActions = true;
            });
          },
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: _showExtendedActions ? 0 : topOffset,
              left: _showExtendedActions ? 0 : marginhorizontal,
              right: _showExtendedActions ? 0 : marginhorizontal,
              //6 because its the shadow offset
              bottom:
                  _showExtendedActions ? 6 : collardimension / 2 + collaroffset,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: _showExtendedActions
                      ? Colors.black.withOpacity(0.94)
                      : Colors.black,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: _showExtendedActions
                      ? const Offset(6, 6)
                      : const Offset(4, 4), // changes position of shadow
                ),
              ],
              //Need Border Radius to draw shadow
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                  // strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(
                  image: const NetworkImage("https://picsum.photos/600/800"),
                  fit: BoxFit.cover,
                  alignment: Alignment(widget.imageAlignmentOffset, 0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: _showExtendedActions ? 1 : 0,
                    child: const Divider(
                      color: Colors.black,
                      thickness: 3,
                      height: 0,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: _duration,
                    curve: _curve,
                    height: _showExtendedActions ? 100 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius)),
                      color: Colors.white,
                    ),
                    child: AnimatedOpacity(
                      duration: _duration,
                      curve: _curve,
                      opacity: _showExtendedActions ? 1 : 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                //To trigger the Hit Box
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: iconFlex,
                                      child: const Center(
                                        child: Icon(
                                          // Icons.ios_share_rounded,
                                          Icons.share_rounded,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Share",
                                      style: extendedActions,
                                    ),
                                    Expanded(
                                        flex: labelFlex,
                                        child: const SizedBox()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                switchLostValue();
                              },
                              child: Container(
                                //To trigger the Hit Box
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: iconFlex,
                                      child: Center(
                                        child: Theme(
                                          data: ThemeData(useMaterial3: true),
                                          child: Switch(
                                            activeTrackColor: activeLostSwitch,
                                            inactiveTrackColor:
                                                inactiveLostSwitch,
                                            value: _switchValue,
                                            onChanged: (_) => switchLostValue(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _switchValue ? "Lost" : "Found",
                                      style: extendedActions,
                                    ),
                                    Expanded(
                                        flex: labelFlex,
                                        child: const SizedBox()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                //To trigger the Hit Box
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: iconFlex,
                                      child: const Center(
                                        child: Icon(
                                          Icons.qr_code_scanner_rounded,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Scans",
                                      style: extendedActions,
                                    ),
                                    Expanded(
                                        flex: labelFlex,
                                        child: const SizedBox()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: _showExtendedActions,
          child: AnimatedOpacity(
            duration: _duration,
            curve: _curve,
            opacity: _showExtendedActions ? 0 : 1,
            child: Hero(
              tag: 'collar${widget.petProfileDetails.profileId}',
              child: Align(
                // alignment: Alignment.bottomCenter,
                alignment: Alignment(widget.imageAlignmentOffset * -0.2, 1),
                child: Tags(
                    tag: widget.petProfileDetails.tag,
                    collardimension: collardimension),
              ),
            ),
          ),
        )
      ],
    );
  }
}
