import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/m_description.dart';

import 'c_component_title.dart';

class PetDescription extends StatefulWidget {
  const PetDescription({super.key});

  @override
  State<PetDescription> createState() => _PetDescriptionState();
}

class _PetDescriptionState extends State<PetDescription> {
  List<Description> _descriptions = [Description("aaa", "en")];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentTitle(text: "Description"),
        ListView.builder(
          itemCount: _descriptions.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == _descriptions.length) {
              // return Row(
              //   children: [
              //     Expanded(
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           labelText: "Enter New Description",
              //           fillColor: Colors.white,
              //           focusedBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.blue,
              //             ),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(25.0),
              //             borderSide: const BorderSide(
              //               color: Colors.red,
              //               width: 2.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       child: const Icon(Icons.language),
              //     )
              //   ],
              // );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      initialValue: _descriptions.elementAt(index).text,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.grey.shade600,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade500),
                        color: Colors.grey.shade100,
                      ),
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox.expand(
                          child: FittedBox(
                            child: Icon(Icons.language),
                          ),
                        ),
                      )),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
