import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/pets/profile_details/models/m_phone_number.dart';

import '../../../language/c_prefix_selection.dart';
import '../../../language/m_language.dart';
import '../u_profile_details.dart';
import '../widgets/custom_textformfield.dart';
import 'c_phone_number.dart';

class SinglePhonerNumber extends StatefulWidget {
  const SinglePhonerNumber({
    super.key,
    required this.number,
    required this.petProfileId,
    required this.removePhoneNumber,
    this.autofocus = false,
  });

  final PhoneNumber number;
  final int petProfileId;
  final VoidCallback removePhoneNumber;
  final bool autofocus;

  @override
  State<SinglePhonerNumber> createState() => _SinglePhonerNumberState();
}

//? Stateless widget?
class _SinglePhonerNumberState extends State<SinglePhonerNumber> {
  void _updatePhoneNumber() {
    EasyDebounce.debounce(
      'updatePhoneNumber',
      const Duration(milliseconds: 250),
      () {
        if (widget.number.phoneNumber.isEmpty) {
          print("delete id ${widget.number.phoneNumberId}");
          deletePhoneNumber(widget.number)
              .then((value) => widget.removePhoneNumber());
        } else {
          updatePhoneNumber(widget.number);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      autofocus: widget.autofocus,
      keyboardType: TextInputType.number,
      initialValue: widget.number.phoneNumber,
      hintText: "XXX",
      ignoreBoxShadow: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        widget.number.phoneNumber = value;
        _updatePhoneNumber();
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
                  widget.number.country = value;
                });
                _updatePhoneNumber();
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
                PrefixBlock(),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.number.country.countryPhonePrefix,
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
    );
  }
}
