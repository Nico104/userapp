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
          itemCount: list.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == list.length) {
              //Create New HealthIssue
              return InkWell(
                onTap: () {
                  BuildContext? dialogContext;
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    builder: (buildContext) {
                      dialogContext = buildContext;
                      return Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );
                  createHealthIssue(
                    healthIssueName: newName,
                    healthIssueType: newType,
                    medicalId: medicalInformationId,
                  ).then(
                    (value) {
                      Navigator.pop(dialogContext!);
                      refreshHealthIssues.call();
                      Navigator.of(context)
                          .push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          pageBuilder: (BuildContext context, _, __) {
                            return HealthIssueUpdateBox(
                              healthIssue: value,
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
                  );
                },
                child: Opacity(
                  opacity: 0.26,
                  child: SizedBox(
                    child: IgnorePointer(
                      child: HealthIssueItem(
                        healthIssue: HealthIssue(math.Random().nextInt(99999),
                            9999, "irrelevant", "Tap to create", null),
                        petProfileId: petProfileId,
                        refreshHealthIssues: refreshHealthIssues,
                      ),
                    ),
                  ),
                ),
              );
            }
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
