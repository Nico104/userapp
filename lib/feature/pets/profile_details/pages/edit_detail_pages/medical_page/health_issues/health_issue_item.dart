import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';

import 'health_issue_update_box.dart';

class HealthIssueItem extends StatelessWidget {
  const HealthIssueItem(
      {super.key,
      required this.healthIssue,
      required this.petProfileId,
      required this.refreshHealthIssues});

  final HealthIssue healthIssue;
  final int petProfileId;

  final VoidCallback refreshHealthIssues;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print("i am a health issue");
        Navigator.of(context)
            .push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, _, __) {
              return HealthIssueUpdateBox(
                healthIssue: healthIssue,
                nameLabel: "Label",
                petProfileId: petProfileId,
              );
            },
          ),
        )
            .then((value) {
          refreshHealthIssues.call();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: "healthIssue${healthIssue.healthIssueId}",
          child: Text(
            healthIssue.healthIssueName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
