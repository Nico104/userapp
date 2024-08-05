import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/contact/u_contact.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_social_media.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

import '../../../general/utils_theme/custom_colors.dart';
import 'c_component_title.dart';
import 'widgets/custom_textformfield.dart';

class SocialMediaComponent extends StatefulWidget {
  const SocialMediaComponent({
    super.key,
    // required this.facebook,
    // required this.saveFacebook,
    // required this.instagram,
    // required this.saveInstagram,
    required this.title,
    required this.socialMedias,
    required this.contactId,
  });

  // final String facebook;
  // final ValueSetter<String> saveFacebook;
  // final String instagram;
  // final ValueSetter<String> saveInstagram;

  final List<SocialMediaConnection> socialMedias;
  final int contactId;
  // final ValueSetter<String> saveSocialMedia;

  final String title;

  @override
  State<SocialMediaComponent> createState() => _SocialMediaComponentState();
}

class _SocialMediaComponentState extends State<SocialMediaComponent> {
  String getHintText(SocialMediaConnection socialMediaConnection) {
    for (SocialMedia socialMedia in availableSocialMedias) {
      if (socialMedia.id == socialMediaConnection.social_media_Id) {
        return socialMedia.hintText;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    print(widget.socialMedias);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: widget.title),
        widget.socialMedias.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.socialMedias.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleSocialMedia(
                      flex: 8,
                      emptyValuePlaceholder:
                          getHintText(widget.socialMedias.elementAt(index)),
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      saveValue: (value) {
                        if (value.isNotEmpty) {
                          widget.socialMedias
                              .elementAt(index)
                              .social_media_account_name = value;
                          upsertSocialMediaConnection(
                              widget.socialMedias.elementAt(index));
                        }
                      },
                      delete: () {
                        deleteSocialMediaConnection(
                            widget.socialMedias.elementAt(index));
                        setState(() {
                          widget.socialMedias.removeAt(index);
                        });
                      },
                      value: widget.socialMedias
                          .elementAt(index)
                          .social_media_account_name,
                      index: 0,
                    ),
                  );
                },
              )
            : SizedBox.shrink(),
        InkWell(
          onTap: () {
            showCustomNicoModalBottomSheet(
              context: context,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                for (SocialMedia social in availableSocialMedias)
                  ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(social.name),
                    onTap: () {
                      upsertSocialMediaConnection(SocialMediaConnection(
                          social.id, widget.contactId, ""));
                      setState(() {
                        widget.socialMedias.add(SocialMediaConnection(
                            social.id, widget.contactId, ""));
                      });

                      Navigator.pop(context);
                    },
                  ),
              ]),
            );
          },
          child: Text(
            "Add Social Media".tr(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }
}

class SingleSocialMedia extends StatelessWidget {
  const SingleSocialMedia({
    super.key,
    required this.value,
    required this.saveValue,
    required this.emptyValuePlaceholder,
    required this.icon,
    required this.index,
    required this.flex,
    required this.delete,
  });

  final String value;
  final ValueSetter<String> saveValue;
  final String emptyValuePlaceholder;
  final Widget icon;
  final int index;
  final int flex;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    getCustomColors(context).lightBorder ?? Colors.transparent,
                width: 0.5,
              ),
              boxShadow: kElevationToShadow[0],
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox.expand(
                  child: FittedBox(
                    child: icon,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: flex,
            child: CustomTextFormField(
              initialValue: value,
              hintText: emptyValuePlaceholder,
              showSuffix: false,
              onChanged: (val) {
                EasyDebounce.debounce(
                  'newDescriptionTranslation$index',
                  const Duration(milliseconds: 500),
                  () {
                    saveValue(val);
                  },
                );
              },
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: delete,
            child: Icon(Icons.delete),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
