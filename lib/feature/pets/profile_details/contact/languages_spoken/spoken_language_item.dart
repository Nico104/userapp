import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../general/network_globals.dart';
import '../../../../../general/widgets/custom_nico_modal.dart';

class SpokenLanguageItem extends StatelessWidget {
  const SpokenLanguageItem({
    super.key,
    required this.languageImagePath,
    required this.onDelete,
  });

  final String languageImagePath;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showOptions(context),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            s3BaseUrl + languageImagePath,
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showCustomNicoModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text("Remove spoken Language"),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
