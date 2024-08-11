import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class AddTagTutorial extends StatefulWidget {
  const AddTagTutorial({super.key});

  @override
  State<AddTagTutorial> createState() => _AddTagTutorialState();
}

class _AddTagTutorialState extends State<AddTagTutorial> {
  double _width = 50.w;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: _width,
                height: _width * 2 / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                // margin: const EdgeInsets.all(16),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "JQY1-65DC-T0PV",
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          color: getCustomColors(context).accentHighContrast,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        TutorialStep(
          title: "Step 1: Locate Your Activation Code",
          subtitle:
              "You’ll find your unique 12-symbol activation code on the card included with your product, as shown in the illustration above.",
        ),
        TutorialStep(
          title: "Step 2: Enter the Activation Code",
          subtitle:
              "In the text field at the top of this page, carefully enter the 16-symbol activation code exactly as it appears on your card.",
        ),
        TutorialStep(
          title: "Step 3: Submit the Code",
          subtitle:
              "After entering the activation code, click the or \"Add Tag\" button to proceed.",
        ),
        TutorialStep(
          title: "Step 4: Confirmation",
          subtitle:
              "Once the process is complete, your dog tag will be successfully linked to your account.",
        ),
        const SizedBox(height: 32),
        // Opacity(
        //   opacity: 0.7,
        //   child: Text(
        //     "In the rare case your packaging didnt have an activation Code please reach out to us",
        //     // style: Theme.of(context).textTheme.displayMedium,
        //     style: GoogleFonts.roboto(fontSize: 14),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        // const SizedBox(height: 12),
        // Text(
        //   "Adding Your Dog Tags to Your Account",
        //   style: Theme.of(context).textTheme.titleMedium,
        // ),
        // const SizedBox(height: 32),
        // Text(
        //   "1. In the text field above, either enter the activation code provided with your dog tag or Scan the QR code on the back of the tag.",
        //   style: Theme.of(context).textTheme.displayMedium,
        // ),
        // const SizedBox(height: 12),
        // Text(
        //   "2. Click \"Submit\" or \"Add Tag\" to proceed.",
        //   style: Theme.of(context).textTheme.displayMedium,
        // ),
        // const SizedBox(height: 12),
        // Text(
        //   "3. Follow any on-screen instructions to complete the process.",
        //   style: Theme.of(context).textTheme.displayMedium,
        // ),
        // const SizedBox(height: 12),
        // Text(
        //   "4. Once done, your dog tag is now linked to your account.",
        //   style: Theme.of(context).textTheme.displayMedium,
        // ),
        // const SizedBox(height: 12),
      ],
    );
  }
}

class TutorialStep extends StatelessWidget {
  const TutorialStep({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          // style: Theme.of(context).textTheme.titleMedium,
          style: GoogleFonts.prompt(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          // style: Theme.of(context).textTheme.displayMedium,
          style: GoogleFonts.openSans(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
