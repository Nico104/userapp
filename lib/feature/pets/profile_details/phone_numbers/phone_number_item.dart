import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_phone_number.dart';

import '../../../../general/network_globals.dart';
import '../../../language/c_prefix_selection.dart';
import '../../../language/country_selector.dart';
import '../../../language/m_language.dart';
import '../contact/u_contact.dart';
import '../d_confirm_delete.dart';
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
    required this.focusNode,
  });

  final PhoneNumber number;
  final int petProfileId;
  final VoidCallback removePhoneNumber;
  final bool autofocus;

  final FocusNode focusNode;

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
      focusNode: widget.focusNode,
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
          // showDialog(
          //   context: context,
          //   builder: (_) => const PrefixPickerDialogComponent(),
          // ).then((value) {
          //   if (value != null) {
          //     if (value is Country) {
          //       setState(() {
          //         widget.number.country = value;
          //       });
          //       _updatePhoneNumber();
          //     }
          //   }
          // });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountrySelector(
                availableCountries: availableCountries,
                activeCountry: widget.number.country,
              ),
            ),
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
          child: Hero(
            tag: widget.number.country.countryKey,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // prefixBlock(),
                  SizedBox(
                    height: 28,
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          s3BaseUrl +
                              widget.number.country.countryFlagImagePath,
                        ),
                      ),
                    ),
                  ),
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
      ),
      confirmDeleteDialog: const ConfirmDeleteDialog(label: "Phone Number"),
    );
  }
}
