import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/feature/auth/u_auth.dart';

import '../../../widgets/settings_widgets.dart';

class UpdateSocialSignIn extends StatelessWidget {
  const UpdateSocialSignIn(
      {super.key,
      required this.label,
      required this.editAccountLink,
      required this.icon});

  final String label;
  final String editAccountLink;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      label: label,
      leading: icon,
      suffix: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        launchUrl(Uri.parse(editAccountLink),
            mode: LaunchMode.externalApplication);
      },
    );
  }
}

// String getProviderIdLabel(ProviderId providerId) {
//   switch (providerId) {
//     case ProviderId.google:
//       return "Edit Google-Account";
//     default:
//       return "Undefined";
//   }
// }

// String getProviderIdEditLink(ProviderId providerId) {
//   switch (providerId) {
//     case ProviderId.google:
//       return "https://myaccount.google.com/";
//     default:
//       return "Undefined";
//   }
// }

// Icon getProviderIdIcon(ProviderId providerId) {
//   switch (providerId) {
//     case ProviderId.google:
//       return const Icon(Icons.interests);
//     default:
//       return const Icon(Icons.alternate_email);
//   }
// }
