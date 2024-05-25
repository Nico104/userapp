import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/widgets/shy_button.dart';
import 'package:userapp/general/utils_color/hex_color.dart';

class ContactUsSuccessPage extends StatelessWidget {
  const ContactUsSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: HexColor("3b3bf5"),
      // extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(-0.7, 0.7),
                  child: Text(
                    "Thank\nYou.",
                    style: GoogleFonts.openSans(
                        fontSize: 96,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.7),
                thickness: 0.5,
                height: 0,
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(-0.7, -0.7),
                  child: Text(
                    "We'll be in touch.\nShortly!",
                    style:
                        GoogleFonts.openSans(fontSize: 36, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          ShyButton(
            bgColor: Colors.white,
            iconBgColor: Colors.black.withOpacity(0.06),
            fontColor: Colors.black.withOpacity(0.84),
            showUploadButton: true,
            onTap: () => Navigator.pop(context),
            label: "Go back",
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black.withOpacity(0.84),
            ),
          ),
        ],
      ),
    );
  }
}
