import 'package:flutter/material.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';

class AddContactHeader extends StatelessWidget {
  const AddContactHeader({
    super.key,
    required this.addNewContact,
  });

  final VoidCallback addNewContact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.fromLTRB(16, 32, 0, 16),
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              child: Text(
                "In order to be contacted when Tabo get found add a new or existing Contact",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                addNewContact();
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        width: 0.5,
                        color: getCustomColors(context).hardBorder ??
                            Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
