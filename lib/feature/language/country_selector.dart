import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/general/widgets/custom_scroll_view.dart';

import '../../general/network_globals.dart';
import '../../general/widgets/loading_indicator.dart';
import 'm_language.dart';

class CountrySelector extends StatefulWidget {
  const CountrySelector({
    super.key,
    required this.availableCountries,
    this.activeCountry,
  });

  final List<Country> availableCountries;
  final Country? activeCountry;

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  late List<Country> filteredCountries;

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.availableCountries;
  }

  void _filterCountries(String filter) {
    setState(() {
      filteredCountries = widget.availableCountries
          .where((country) =>
              country.name.toLowerCase().contains(filter.toLowerCase()) ||
              country.dial_code.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNicoScrollView(
        title: Text("selectCountry".tr()),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 28),
              widget.activeCountry != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Hero(
                            tag: widget.activeCountry!.code,
                            child:
                                SingleCountry(country: widget.activeCountry!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 0.5,
                            height: 0,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              CustomTextFormField(
                hintText: "Search".tr(),
                ignoreBoxShadow: true,
                onChanged: (value) {
                  _filterCountries(value);
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCountries.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  bool isActive = false;
                  if (widget.activeCountry != null) {
                    if (widget.activeCountry?.code ==
                        filteredCountries.elementAt(index).code) {
                      isActive = true;
                    }
                  }

                  return Opacity(
                    opacity: isActive ? 0.3 : 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          isActive ? null : filteredCountries.elementAt(index),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: SingleCountry(
                          country: filteredCountries.elementAt(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        onScroll: () {},
      ),
    );
  }
}

class SingleCountry extends StatelessWidget {
  const SingleCountry({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SizedBox(
        //   height: 40,
        //   child: AspectRatio(
        //     aspectRatio: 3 / 2,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(4),
        //       child: CachedNetworkImage(
        //         imageUrl: s3BaseUrl + country.countryFlagImagePath,
        //         placeholder: (context, url) => const CustomLoadingIndicatior(),
        //         errorWidget: (context, url, error) => const Icon(Icons.error),
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(width: 16),
        //Put countrykey as a translation element
        Text(
          country.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Spacer(),
        Text(
          "(${country.dial_code})",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
