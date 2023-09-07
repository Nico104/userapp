import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';
import 'package:userapp/general/utils_general.dart';

import '../../../../../u_pets.dart';
import '../../../../c_one_line_simple_input.dart';
import '../../../../widgets/custom_textformfield.dart';
import 'health_issues_choose_document.dart';

class HealthIssueUpdateBox extends StatefulWidget {
  const HealthIssueUpdateBox(
      {super.key,
      required this.healthIssue,
      required this.nameLabel,
      required this.petProfileId});

  final HealthIssue healthIssue;
  final String nameLabel;
  final int petProfileId;

  @override
  State<HealthIssueUpdateBox> createState() => _HealthIssueUpdateBoxState();
}

class _HealthIssueUpdateBoxState extends State<HealthIssueUpdateBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late HealthIssue _healthIssue;

  @override
  void initState() {
    super.initState();
    _healthIssue = widget.healthIssue;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.06),
          child: Center(
            child: Hero(
              tag: "healthIssue${_healthIssue.healthIssueId}",
              child: Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 80.w,
                        minWidth: 40.w,
                        maxHeight: 50.h,
                        minHeight: 20.h,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Edit",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  initialValue: _healthIssue.healthIssueName,
                                  hintText: "George the Second",
                                  showSuffix: false,
                                  onChanged: (val) {
                                    _healthIssue.healthIssueName = val;
                                  },
                                  validator: (p0) {
                                    if (p0 != null && p0.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Name cannot be empty";
                                    }
                                  },
                                ),
                              ),
                            ),
                            _healthIssue.linkedDocuemntId == null
                                ? FutureBuilder(
                                    future:
                                        getPetDocuments(widget.petProfileId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.isNotEmpty) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      HealthIssueLinkDocumentSelection(
                                                    petProfileId:
                                                        widget.petProfileId,
                                                    documents: snapshot.data!,
                                                    healthIssueId: widget
                                                        .healthIssue
                                                        .healthIssueId,
                                                  ),
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 125),
                                                  reverseTransitionDuration:
                                                      const Duration(
                                                          milliseconds: 80),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    const begin =
                                                        Offset(1.0, 0.0);
                                                    const end = Offset.zero;
                                                    final tween = Tween(
                                                        begin: begin, end: end);
                                                    final offsetAnimation =
                                                        animation.drive(tween);

                                                    return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              ).then((value) {
                                                if (value is HealthIssue) {
                                                  setState(() {
                                                    _healthIssue = value;
                                                  });
                                                }
                                              });
                                            },
                                            child: Container(
                                              child:
                                                  const Text("Link Document"),
                                            ),
                                          );
                                        } else {
                                          return const Text(
                                              "No Documents to link");
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          "error loading version",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        );
                                      } else {
                                        //Loading
                                        return Text(
                                          "Loading Version",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        );
                                      }
                                    },
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
