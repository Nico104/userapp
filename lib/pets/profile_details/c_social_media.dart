import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import '../../../styles/text_styles.dart';
import '../../theme/custom_colors.dart';
import 'c_component_title.dart';
import 'widgets/custom_textformfield.dart';

class SocialMediaComponent extends StatelessWidget {
  const SocialMediaComponent({
    super.key,
    required this.facebook,
    required this.saveFacebook,
    required this.instagram,
    required this.saveInstagram,
    required this.title,
  });

  final String facebook;
  final ValueSetter<String> saveFacebook;
  final String instagram;
  final ValueSetter<String> saveInstagram;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: title),
        SingleSocialMedia(
          flex: 8,
          emptyValuePlaceholder: "https:/facebook/profile/LongusSchlongus",
          icon: const Icon(
            Icons.facebook,
            color: Colors.blue,
          ),
          saveValue: saveFacebook,
          value: facebook,
          index: 0,
        ),
        const SizedBox(
          height: 16,
        ),
        SingleSocialMedia(
          flex: 4,
          emptyValuePlaceholder: "@LongusSchlongus",
          icon: const Icon(
            Icons.facebook,
            color: Colors.pink,
          ),
          saveValue: saveInstagram,
          value: instagram,
          index: 1,
        ),
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
  });

  final String value;
  final ValueSetter<String> saveValue;
  final String emptyValuePlaceholder;
  final Icon icon;
  final int index;
  final int flex;

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
            child: CustomTextFormFieldActive(
              hintText: emptyValuePlaceholder,
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
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
