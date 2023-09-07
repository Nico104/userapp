import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';

import 'health_issue_item.dart';
import 'dart:math' as math;

class HealthIssueList extends StatelessWidget {
  const HealthIssueList(
      {super.key,
      required this.list,
      required this.title,
      required this.petProfileId});

  final List<HealthIssue> list;
  final String title;
  final int petProfileId;

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
          itemCount: list.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == list.length) {
              return InkWell(
                onTap: () {
                  print("fdgfasgadfhghsdf");
                },
                child: Opacity(
                  opacity: 0.26,
                  child: SizedBox(
                    child: IgnorePointer(
                      child: HealthIssueItem(
                        healthIssue: HealthIssue(math.Random().nextInt(99999),
                            9999, "irrelevant", "Tap to create", null),
                        petProfileId: petProfileId,
                      ),
                    ),
                  ),
                ),
              );
            }
            return HealthIssueItem(
              healthIssue: list.elementAt(index),
              petProfileId: petProfileId,
            );
          },
        ),
      ],
    );
  }
}
