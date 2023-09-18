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
        "Every change gets saved and uploaded automatically",
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
