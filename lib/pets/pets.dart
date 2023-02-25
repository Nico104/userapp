import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'pet_profile_preview.dart';

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
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: widget.bottomoffset),
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
                    index: position,
                  );
                },
                itemCount: 4,
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                // type: WormType.thin,
                // strokeWidth: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
