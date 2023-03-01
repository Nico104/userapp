import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'pet_profile_preview.dart';
import 'profile_details/models/m_tag.dart';
import 'u_pets.dart';

class Pets extends StatefulWidget {
  const Pets({super.key, required this.bottomoffset});

  final double bottomoffset;

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  final PageController _controller =
      PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Pets"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProfileDetailView(
                        petProfileDetails:
                            PetProfileDetails.createNewEmptyProfile(
                          List<Tag>.empty(growable: false),
                        ),
                      ),
                    ),
                  ),
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: widget.bottomoffset),
        child: FutureBuilder<List<PetProfileDetails>>(
          future:
              fetchUserPets(), // a previously-obtained Future<String> or null
          builder: (BuildContext context,
              AsyncSnapshot<List<PetProfileDetails>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 02.h, top: 02.h),
                        height: 80.h - widget.bottomoffset,
                        child: PageView.builder(
                          controller: _controller,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return PetProfilePreview(
                              petProfileDetails:
                                  snapshot.data!.elementAt(position),
                            );
                          },
                          // itemCount: 4,
                          itemCount: snapshot.data!.length,
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: snapshot.data!.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          // type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("No Pets, create?"));
              }
            } else if (snapshot.hasError) {
              //Error
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ],
                ),
              );
            } else {
              //Loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
