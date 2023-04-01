import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_phone_number.dart';
import 'package:userapp/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'package:userapp/styles/text_styles.dart';
import '../../language/c_prefix_selection.dart';
import '../../language/m_language.dart';
import '../../theme/custom_colors.dart';
import 'c_component_title.dart';

class PetPhoneNumbersComponent extends StatefulWidget {
  const PetPhoneNumbersComponent({
    super.key,
    required this.phoneNumbers,
    required this.petProfileId,
  });

  final int? petProfileId;
  //Pass by reference
  final List<PhoneNumber> phoneNumbers;

  @override
  State<PetPhoneNumbersComponent> createState() =>
      _PetPhoneNumbersComponentState();
}

class _PetPhoneNumbersComponentState extends State<PetPhoneNumbersComponent> {
  // final ValueSetter<Description> addDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentTitle(text: "Phone Numbers"),
        ListView.builder(
          itemCount: widget.phoneNumbers.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.phoneNumbers.length) {
              return NewPhonerNumber(
                addNewPhoneNumber: (number, language) {
                  setState(() {
                    widget.phoneNumbers.add(PhoneNumber(
                        widget.petProfileId, number, 999, language));
                  });
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SinglePhonerNumber(
                  //Pass by reference
                  number: widget.phoneNumbers.elementAt(index),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class SinglePhonerNumber extends StatefulWidget {
  const SinglePhonerNumber({super.key, required this.number});

  final PhoneNumber number;

  @override
  State<SinglePhonerNumber> createState() => _SinglePhonerNumberState();
}

class _SinglePhonerNumberState extends State<SinglePhonerNumber> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => PrefixPickerDialogComponent(),
                ).then((value) {
                  if (value != null) {
                    if (value is Language) {
                      setState(() {
                        widget.number.language = value;
                      });
                    }
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                    width: 0.5,
                  ),
                  boxShadow: kElevationToShadow[2],
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // height: double.infinity,
                      width: 28,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue
                          // image: DecorationImage(
                          //   image: NetworkImage(description.language.languageImagePath),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ),
                    Text(
                      widget.number.language.languagePrefix,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                )),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 10,
            child: CustomTextFormFieldActive(
              initialValue: widget.number.phoneNumber,
              hintText: "XXX",
            ),
          ),
          const Spacer(flex: 2),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}

class NewPhonerNumber extends StatefulWidget {
  const NewPhonerNumber({
    super.key,
    required this.addNewPhoneNumber,
  });

  final Function(String number, Language language) addNewPhoneNumber;

  @override
  State<NewPhonerNumber> createState() => _NewPhonerNumberState();
}

class _NewPhonerNumberState extends State<NewPhonerNumber> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const PrefixPickerDialogComponent(),
                ).then((value) {
                  if (value != null) {
                    if (value is Language) {
                      widget.addNewPhoneNumber(_text, value);
                    }
                  }
                });
              },
              child: Opacity(
                opacity: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getCustomColors(context).lightBorder ??
                          Colors.transparent,
                      width: 0.5,
                    ),
                    boxShadow: kElevationToShadow[4],
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                      child: Opacity(
                    opacity: 0.24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          CustomIcons.globe_5,
                        ),
                        Text(
                          "+**",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 10,
            //? Could use normal Textfield only and just change all opacity
            // child: CustomTextFormFieldInactive(
            //   hintText: "Enter new Number",
            //   onChanged: (val) {
            //     EasyDebounce.debounce(
            //       'newPhoneNumber',
            //       const Duration(milliseconds: 500),
            //       () {
            //         setState(() {
            //           _text = val;
            //         });
            //       },
            //     );
            //   },
            // ),
            child: CustomTextFormFieldActive(
              hintText: "384 432 5683",
              onChanged: (val) {
                EasyDebounce.debounce(
                  'newPhoneNumber',
                  const Duration(milliseconds: 500),
                  () {
                    setState(() {
                      _text = val;
                    });
                  },
                );
              },
            ),
          ),
          const Spacer(flex: 2),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
