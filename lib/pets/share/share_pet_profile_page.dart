import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/share/share_button.dart';

import '../../network_globals.dart';

class SharePetProfilePage extends StatefulWidget {
  const SharePetProfilePage({
    Key? key,
    required this.petProfileDetails,
  }) : super(key: key);

  final PetProfileDetails petProfileDetails;

  @override
  State<SharePetProfilePage> createState() => _SharePetProfilePageState();
}

class _SharePetProfilePageState extends State<SharePetProfilePage> {
  final double _imageBorderRadius = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share ${widget.petProfileDetails.petName}'s Profile"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_imageBorderRadius),
                boxShadow: kElevationToShadow[2],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_imageBorderRadius),
                child: Image.network(
                  widget.petProfileDetails.petPictures.isNotEmpty
                      ? s3BaseUrl +
                          widget.petProfileDetails.petPictures.first
                              .petPictureLink
                      : "https://picsum.photos/600/800",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SharePageButton(
                    prefix: const Icon(Icons.pets),
                    label:
                        "Share ${widget.petProfileDetails.petName}'s Profile",
                    onTap: () {
                      Share.share(
                          'check out my dope ass dog\nhttps://example.com',
                          subject: 'Look at my dope ass dog!');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SharePageButton(
                    prefix: const Icon(Icons.file_copy),
                    label:
                        "Share ${widget.petProfileDetails.petName}'s official Information",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
