import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/c_component_title.dart';
import 'package:userapp/feature/pets/profile_details/models/m_phone_number.dart';
import 'package:userapp/feature/pets/profile_details/phone_numbers/phone_number_item.dart';
import 'package:userapp/feature/pets/profile_details/phone_numbers/phone_number_new_item.dart';

class PetPhoneNumbersComponent extends StatefulWidget {
  const PetPhoneNumbersComponent({
    super.key,
    required this.phoneNumbers,
    required this.contactId,
  });

  final int contactId;
  //Pass by reference
  final List<PhoneNumber> phoneNumbers;

  @override
  State<PetPhoneNumbersComponent> createState() =>
      _PetPhoneNumbersComponentState();
}

class _PetPhoneNumbersComponentState extends State<PetPhoneNumbersComponent> {
  // final ValueSetter<Description> addDescription;

  // bool autofocusLastElement = false;

  late List<FocusNode> _focusNodes;
  final FocusNode _newNumberFocusNodes = FocusNode();

  @override
  void initState() {
    super.initState();
    generateFocusNodes();
  }

  void generateFocusNodes() {
    _focusNodes =
        List.generate(widget.phoneNumbers.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    super.dispose();
    _newNumberFocusNodes.dispose();
    for (var element in _focusNodes) {
      element.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: "profileDetailsComponentTitlePhoneNumbers".tr()),
        ListView.builder(
          key: Key(widget.phoneNumbers.length.toString()),
          itemCount: widget.phoneNumbers.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.phoneNumbers.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: NewPhonerNumber(
                  contactId: widget.contactId,
                  addNewPhoneNumber: (number) {
                    setState(() {
                      widget.phoneNumbers.add(number);
                    });
                    generateFocusNodes();
                    _focusNodes.last.requestFocus();
                    // setState(() {
                    //   autofocusLastElement = true;
                    // });
                  },
                  focusNode: _newNumberFocusNodes,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SinglePhonerNumber(
                  //Pass by reference
                  number: widget.phoneNumbers.elementAt(index),
                  petProfileId: widget.contactId,
                  removePhoneNumber: () {
                    setState(() {
                      widget.phoneNumbers.removeAt(index);
                      // autofocusLastElement = false;
                    });
                    generateFocusNodes();
                    if (_focusNodes.isNotEmpty) {
                      _focusNodes.last.requestFocus();
                    } else {
                      _newNumberFocusNodes.requestFocus();
                    }
                  },
                  // autofocus: (autofocusLastElement &&
                  //     index == widget.phoneNumbers.length - 1),
                  focusNode: _focusNodes.elementAt(index),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

Widget prefixBlock() {
  return AspectRatio(
    aspectRatio: 3 / 2,
    child: Container(
      // height: double.infinity,
      // width: 36,
      height: 28,
      decoration:
          const BoxDecoration(shape: BoxShape.rectangle, color: Colors.redAccent
              // image: DecorationImage(
              //   image: NetworkImage(description.language.languageImagePath),
              //   fit: BoxFit.cover,
              // ),
              ),
    ),
  );
}
