import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/languages_spoken/spoken_language_item.dart';
import 'package:userapp/feature/pets/profile_details/models/m_contact.dart';

import '../../c_component_title.dart';
import '../../g_profile_detail_globals.dart';
import '../u_contact.dart';
import 'add_language_button.dart';
import 'no_languages_widget.dart';

class LanguagesSpoken extends StatefulWidget {
  const LanguagesSpoken(
      {super.key, required this.contact, required this.reloadContact});

  final Contact contact;
  final VoidCallback reloadContact;

  @override
  State<LanguagesSpoken> createState() => _LanguagesSpokenState();
}

class _LanguagesSpokenState extends State<LanguagesSpoken> {
  final double _height = 90;

  final ScrollController _scrollController = ScrollController();

  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        scrollToEnd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: "languagesSpokenWidget_languagesspoken".tr()),
        widget.contact.languagesSpoken.isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: _height,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.contact.languagesSpoken.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  right: 8,
                                  bottom: 4,
                                ),
                                child: SpokenLanguageItem(
                                  languageImagePath: widget
                                      .contact.languagesSpoken
                                      .elementAt(index)
                                      .languageImagePath,
                                  onDelete: () {
                                    disconnectLanguageSpoken(
                                            widget.contact.contactId,
                                            widget.contact.languagesSpoken
                                                .elementAt(index)
                                                .languageKey)
                                        .then(
                                      (value) => widget.reloadContact(),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        //Blurs outgoung language
                        Align(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                width: 5,
                                height: _height,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 100,
                    child: AddSpokenLanguageButton(
                      addLangauge: (language) {
                        connectLanguageSpoken(
                                widget.contact.contactId, language.languageKey)
                            .then((value) {
                          widget.reloadContact();
                          scrollToEnd();
                        });
                      },
                      title: "languagesSpokenWidget_addSpokenLanguage".tr(),
                      availableLanguages: availableLanguages,
                      unavailableLanguages: widget.contact.languagesSpoken,
                    ),
                  ),
                ],
              )
            : NoLanguages(
                contactId: widget.contact.contactId,
                reloadContact: widget.reloadContact,
              ),
      ],
    );
  }
}
