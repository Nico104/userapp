import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/general/utils_general.dart';

import '../../../pets/profile_details/models/m_pet_profile.dart';
import '../../../pets/profile_details/profile_detail_view.dart';
import '../../../../general/utils_theme/custom_colors.dart';

class GoToProfileButton extends StatelessWidget {
  const GoToProfileButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // color: getCustomColors(context).accent
          color: Theme.of(context).primaryColor,
          border: Border.all(
            width: 1,
            color: getCustomColors(context).lightBorder ?? Colors.transparent,
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(8),
          //The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
          boxShadow: kElevationToShadow[0],
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

class DeleteTagButton extends StatelessWidget {
  const DeleteTagButton({
    super.key,
    required this.deleteTag,
    required this.label,
  });

  final VoidCallback deleteTag;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        deleteTag.call();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: getCustomColors(context).error!.withOpacity(0.5),
          border: Border.all(
            width: 1,
            color: getCustomColors(context).lightBorder ?? Colors.transparent,
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(18),
          //The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
          boxShadow: kElevationToShadow[0],
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
