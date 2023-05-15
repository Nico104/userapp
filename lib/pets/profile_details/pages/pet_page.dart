import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/pages/profile_info_page.dart';

import '../../../styles/custom_icons_icons.dart';
import '../../../theme/custom_text_styles.dart';
import '../../tag/tags.dart';
import '../c_pet_name.dart';

class PetPage extends StatefulWidget {
  const PetPage({
    super.key,
    required this.getProfileDetails,
  });

  // final PetProfileDetails petProfileDetails;
  final PetProfileDetails Function() getProfileDetails;

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  final double tagDimension = 170;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // initialIndex: 1,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              //Picture Tag
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 100.w,
                    height: 100.w,
                    margin: EdgeInsets.only(bottom: tagDimension * 0.69),
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(14),
                      // boxShadow: kElevationToShadow[4],
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/512"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Tags(
                      collardimension: tagDimension,
                      tag: widget.getProfileDetails().tag),
                ],
              ),
              const SizedBox(height: 20),
              //Name
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.getProfileDetails().petName,
                        style:
                            getCustomTextStyles(context).profileDetailsPetName,
                      ),
                      GestureDetector(
                        // onTap: () => askForPetName(
                        //     context, widget.setPetName, widget.petName),
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 14, bottom: 14, right: 14),
                          child: Icon(
                            CustomIcons.edit_square,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  widget.getProfileDetails().petGender != Gender.none
                      ? Text(
                          getPetTitle(widget.getProfileDetails().petGender),
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 36),
              TabBar(
                tabs: const [
                  Tab(icon: Icon(Icons.pets)),
                  Tab(icon: Icon(Icons.image)),
                  Tab(icon: Icon(Icons.file_copy)),
                ],
                onTap: (value) {
                  // print(value);
                  // setState(() {
                  //   index = value;
                  // });
                },
              ),
              const SizedBox(height: 28),
              ProfileInfoTab(
                petProfileDetails: widget.getProfileDetails(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
