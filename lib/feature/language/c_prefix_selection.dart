import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';

import 'm_language.dart';

class PrefixPickerDialogComponent extends StatelessWidget {
  const PrefixPickerDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: 70.w,
        // height: 60.h,
        constraints: BoxConstraints(maxHeight: 60.h),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Prefix",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              ListView.builder(
                itemCount: availableCountries.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SinglePrefix(
                          country: availableCountries.elementAt(index)),
                      (index != availableCountries.length - 1)
                          ? const Divider()
                          : const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SinglePrefix extends StatelessWidget {
  const SinglePrefix({
    super.key,
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, country),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/60"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 36),
              Text(country.countryKey),
              Text("+(${country.countryPhonePrefix})"),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
