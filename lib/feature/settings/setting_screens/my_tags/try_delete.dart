import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/feature/settings/setting_screens/my_tags/my_tag_tile_buttons.dart';

import '../../../../general/utils_theme/custom_colors.dart';

class TryDelete extends StatelessWidget {
  const TryDelete({super.key, required this.cancel, required this.delete});

  final VoidCallback cancel;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: getCustomColors(context).accent
        color: Theme.of(context).primaryColor,
        border: Border.all(
          width: 1,
          color: getCustomColors(context).lightBorder ?? Colors.transparent,
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(28),
        //The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
        boxShadow: kElevationToShadow[8],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delete",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Fur real bra",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DeleteTagButton(
                      deleteTag: () {
                        delete.call();
                      },
                      label: "Delete",
                    ),
                    GoToProfileButton(
                      onTap: () {
                        cancel.call();
                      },
                      label: "Cancel",
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
