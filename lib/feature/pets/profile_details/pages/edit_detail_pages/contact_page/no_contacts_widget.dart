import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';

class NoContactsWidget extends StatelessWidget {
  const NoContactsWidget({Key? key, required this.addNewContact})
      : super(key: key);

  final VoidCallback addNewContact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "addContactHeader_inOrderToBeContactedAddContact".tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: InkWell(
            onTap: () {
              addNewContact();
            },
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    width: 0.5,
                    color: getCustomColors(context).hardBorder ??
                        Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add new Contact".tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
