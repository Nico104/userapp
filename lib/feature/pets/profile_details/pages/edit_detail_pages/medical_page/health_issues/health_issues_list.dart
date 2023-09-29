import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';

import 'health_issue_item.dart';
import 'dart:math' as math;

import 'health_issue_update_box.dart';

class HealthIssueList extends StatelessWidget {
  const HealthIssueList(
      {super.key,
      required this.list,
      required this.title,
      required this.petProfileId,
      required this.refreshHealthIssues,
      required this.newName,
      required this.newType,
      required this.medicalInformationId});

  final List<HealthIssue> list;
  final String title;
  final String newName;
  final String newType;
  final int medicalInformationId;
  final int petProfileId;

  final VoidCallback refreshHealthIssues;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            // textAlign: TextAlign.left,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return HealthIssueItem(
              healthIssue: list.elementAt(index),
              petProfileId: petProfileId,
              refreshHealthIssues: refreshHealthIssues,
            );
          },
        ),
      ],
    );
  }
}
