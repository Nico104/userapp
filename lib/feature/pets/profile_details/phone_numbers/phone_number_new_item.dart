import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/feature/pets/profile_details/models/m_phone_number.dart';

import '../../../language/c_prefix_selection.dart';
import '../../../language/m_language.dart';
import '../contact/u_contact.dart';
import '../u_profile_details.dart';
import '../widgets/custom_textformfield.dart';
import 'c_phone_number.dart';

class NewPhonerNumber extends StatefulWidget {
  const NewPhonerNumber({
    super.key,
    required this.addNewPhoneNumber,
    required this.contactId,
    required this.focusNode,
  });

  final Function(PhoneNumber number) addNewPhoneNumber;
  final int contactId;

  final FocusNode focusNode;

  @override
  State<NewPhonerNumber> createState() => _NewPhonerNumberState();
}

class _NewPhonerNumberState extends State<NewPhonerNumber> {
  late Country _country;

  @override
  void initState() {
    super.initState();
    //TODO get user country prefix
    _country =
        Country('de', '/germany', '+49', Language('Deutsch', 'de', false));
  }

  void addPhoneNumber(String number) {
    EasyDebounce.debounce(
      'newPhoneNumber',
      const Duration(milliseconds: 500),
      () {
        if (number.isNotEmpty) {
          createPhoneNumber(widget.contactId, _country.countryKey, number)
              .then((value) => widget.addNewPhoneNumber(value));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: CustomTextFormField(
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        hintText: "Add new Phone number...",
        ignoreBoxShadow: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          addPhoneNumber(value);
        },
        prefix: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => const PrefixPickerDialogComponent(),
            ).then((value) {
              if (value != null) {
                if (value is Country) {
                  setState(() {
                    // widget.number.language = value;
                    _country = value;
                  });
                }
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: prefixBlock(),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    _country.countryPhonePrefix,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const VerticalDivider(
                    color: Colors.black26,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
