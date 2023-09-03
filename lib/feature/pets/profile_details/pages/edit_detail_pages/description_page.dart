import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/m_description.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage(
      {super.key, required this.descriptions, required this.petProfileId});

  final List<Description> descriptions;
  final int petProfileId;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Description"),
        ),
        body: Column(
          children: [
            Expanded(
              child: isolateLanguagesFromDescription(widget.descriptions)
                      .isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          isolateLanguagesFromDescription(widget.descriptions)
                                  .length +
                              1,
                      itemBuilder: (context, index) {
                        if (index ==
                            isolateLanguagesFromDescription(widget.descriptions)
                                .length) {
                          // return +
                        }
                        return Container(
                          child: Text(
                            isolateLanguagesFromDescription(widget.descriptions)
                                .elementAt(index)
                                .languageLabel,
                          ),
                        );
                      },
                    )
                  : ListView(
                      children: [
                        Container(
                          child: Text(
                            "Default Language",
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ));
  }
}
