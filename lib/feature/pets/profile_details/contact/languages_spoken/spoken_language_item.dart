import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/widgets/loading_indicator.dart';

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
          child: CachedNetworkImage(
            imageUrl: s3BaseUrl + languageImagePath,
            placeholder: (context, url) => const CustomLoadingIndicatior(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
            title: Text("spokenlanguageItem_removeSpokenLanguage".tr()),
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
