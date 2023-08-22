import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';

import '../../../pets/profile_details/widgets/custom_textformfield.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarLangaugeSettings".tr()),
      ),
      // body: Padding(
      //     padding: const EdgeInsets.only(left: 28, right: 28),
      //     child: ListView(
      //       children: [
      //         Container(
      //           width: 40,
      //           height: 40,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             image: DecorationImage(
      //               image: NetworkImage("https://picsum.photos/60"),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         SizedBox(width: 42),
      //         Text(language.languageLabel),
      //         TextButton(
      //           onPressed: () {
      //             context.setLocale(Locale('en', 'US'));
      //           },
      //           child: Text("English"),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             context.setLocale(Locale('de', 'DE'));
      //           },
      //           child: Text("Deutsch"),
      //         ),
      //       ],
      //     )),
      // body: GridView.builder(
      //   itemCount: availableLanguages.length,
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Container(
      //           width: 40,
      //           height: 40,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             image: DecorationImage(
      //               image: NetworkImage("https://picsum.photos/60"),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 16),
      //         Text(availableLanguages.elementAt(index).languageLabel),
      //       ],
      //     );
      //   },
      // ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // maxCrossAxisExtent: 200,
            // // childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
          ),
          itemCount: availableLanguages.length,
          itemBuilder: (BuildContext ctx, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/60"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(availableLanguages.elementAt(index).languageLabel),
              ],
            );
          }),
    );
  }
}
