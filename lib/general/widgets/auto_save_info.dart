import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AutoSaveInfo extends StatelessWidget {
  const AutoSaveInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        "autoSaveInfo".tr(),
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
