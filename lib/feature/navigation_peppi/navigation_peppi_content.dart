import 'package:flutter/material.dart';
import 'package:userapp/feature/navigation_peppi/scan_siglinde.dart';
import 'package:userapp/feature/navigation_peppi/share_seppi.dart';

import '../pets/profile_details/models/m_pet_profile.dart';
import 'default_peppi.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.goToDetails,
    // required this.goToScans,
    // required this.goToShare,
    required this.petProfileDetails,
    required this.reloadFuture,
    required this.resetNavigationPeppi,
    required this.scans,
    required this.share,
    required this.goToScans,
    required this.goToShare,
  });

  final bool scans;
  final bool share;

  final VoidCallback goToDetails;
  final VoidCallback goToScans;
  final VoidCallback goToShare;

  final PetProfileDetails petProfileDetails;
  final VoidCallback reloadFuture;
  final VoidCallback resetNavigationPeppi;

  // void resetActionsButtonContent() {
  Widget getCurrentWidget() {
    if (!scans && !share) {
      return DefaultPeppi(
        goToDetails: goToDetails,
        goToScans: goToScans,
        goToShare: goToShare,
      );
    } else if (scans) {
      return const ScanSiglinde();
    } else {
      return ShareSeppi(
        closeShareSeppi: resetNavigationPeppi,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 80),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 80),
        child: getCurrentWidget(),
      ),
    );
  }
}
