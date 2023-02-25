import 'package:flutter/material.dart';
import '../collar_test.dart';

class PetNameComponent extends StatelessWidget {
  const PetNameComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
          tag: 'collartest0',
          child: CollarTest(collardimension: 100),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Taco"),
            Text("Good boy"),
          ],
        ),
        Spacer(),
        Icon(Icons.edit),
      ],
    );
  }
}
