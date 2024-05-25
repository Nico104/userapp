import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/feature/pets/profile_details/models/m_phone_number.dart';

import '../../../../general/network_globals.dart';
import '../../../language/country_selector.dart';
import '../../../language/m_language.dart';
import '../contact/u_contact.dart';
import '../g_profile_detail_globals.dart';
import '../widgets/custom_textformfield.dart';

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
    _country = Country('de', 'flags/language/german_flag.png', '+49',
        Language('Deutsch', 'de', "flags/language/german_flag.png", false));
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
        hintText: "phoneNumberNewItem_addNewNumber".tr(),
        ignoreBoxShadow: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          addPhoneNumber(value);
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
            //         // widget.number.language = value;
            //         _country = value;
            //       });
            //     }
            //   }
            // });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountrySelector(
                  availableCountries: availableCountries,
                  activeCountry: null,
                ),
              ),
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
                    child: SizedBox(
                      height: 28,
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            s3BaseUrl + _country.countryFlagImagePath,
                          ),
                        ),
                      ),
                    ),
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
